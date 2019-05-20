#include <boost/format.hpp>
#include <iostream>
#include <memory>
#include <mutex>

#include <pcl/common/transforms.h>
#include <pcl/filters/filter.h>
#include <pcl/filters/voxel_grid.h>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <nav_msgs/Odometry.h>
#include <pcl_ros/point_cloud.h>
#include <pluginlib/class_list_macros.h>
#include <ros/ros.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/PointCloud2.h>
#include <tf/transform_broadcaster.h>
#include <tf_conversions/tf_eigen.h>
#include <visualization_msgs/MarkerArray.h>

//#include <hdl_people_tracking/ClusterArray.h>
#include "cti_msgs/CloudClusterArray.h"
#include "cti_msgs/CloudCluster.h"

#include <hdl_people_detection/people_detector.h>
#include <hdl_people_detection/background_subtractor.hpp>

#include "glog/logging.h"

using namespace google;
using namespace hdl_people_detection;

class PersonDetectorNode {
 public:
  using PointT = pcl::PointXYZI;

  PersonDetectorNode(ros::NodeHandle nh) {
    LOG(INFO) << "initial person detection..";
//    nh = getNodeHandle();
//    mt_nh = getMTNodeHandle();
//    private_nh = getPrivateNodeHandle();

    private_nh = nh;

    initialize_params();

    // publishers
    backsub_points_pub = private_nh.advertise<sensor_msgs::PointCloud2>("backsub_points", 5);
    cluster_points_pub = private_nh.advertise<sensor_msgs::PointCloud2>("cluster_points", 5);
    human_points_pub = private_nh.advertise<sensor_msgs::PointCloud2>("human_points", 5);
    detection_markers_pub = private_nh.advertise<visualization_msgs::MarkerArray>("detection_markers", 5);
    backsub_voxel_points_pub = private_nh.advertise<sensor_msgs::PointCloud2>("backsub_voxel_points", 1, true);
    backsub_voxel_markers_pub = private_nh.advertise<visualization_msgs::Marker>("backsub_voxel_marker", 1, true);
    clusters_pub = private_nh.advertise<cti_msgs::CloudClusterArray>("/cti/perception/clusters", 10);

    // subscribers
    globalmap_sub = nh.subscribe("/globalmap", 1, &PersonDetectorNode::globalmap_callback, this);

    if (private_nh.param<bool>("static_sensor", true)) {
      static_points_sub = mt_nh.subscribe("/cti/sensor/rslidar/PointCloud2", 32, &PersonDetectorNode::callback_static, this);
    } else {
      ROS_INFO("get static_sensor from params to false");
      odom_sub.reset(new message_filters::Subscriber<nav_msgs::Odometry>(mt_nh, "/odom", 20));
      points_sub.reset(new message_filters::Subscriber<sensor_msgs::PointCloud2>(mt_nh, "/cti/sensor/rslidar/PointCloud2", 20));
      sync.reset(new message_filters::TimeSynchronizer<nav_msgs::Odometry, sensor_msgs::PointCloud2>(*odom_sub, *points_sub, 20));
      sync->registerCallback(boost::bind(&PersonDetectorNode::callback, this, _1, _2));
    }
    LOG(INFO) << "person detector initialize done, ready to detect person on lidar";
  }
  virtual ~PersonDetectorNode() {}

 private:
  void initialize_params() {
    double downsample_resolution =
        private_nh.param<double>("downsample_resolution", 0.1);
    boost::shared_ptr<pcl::VoxelGrid<PointT>> voxelgrid(
        new pcl::VoxelGrid<PointT>());
    voxelgrid->setLeafSize(downsample_resolution, downsample_resolution,
                           downsample_resolution);
    downsample_filter = voxelgrid;

    LOG(INFO) << "create people detector";
    detector.reset(new PeopleDetector(private_nh));
  }

  void callback_static(const sensor_msgs::PointCloud2ConstPtr &points_msg) {
    if (!globalmap) {
      ROS_INFO("constructing globalmap from a points msg");
      globalmap_callback(points_msg);
      ROS_INFO("done");
      return;
    }

    pcl::PointCloud<PointT>::Ptr cloud(new pcl::PointCloud<PointT>());
    pcl::fromROSMsg(*points_msg, *cloud);
    if (cloud->empty()) {
      ROS_ERROR("cloud is empty!!");
      return;
    }

    // downsampling
    pcl::PointCloud<PointT>::Ptr downsampled(new pcl::PointCloud<PointT>());
    downsample_filter->setInputCloud(cloud);
    downsample_filter->filter(*downsampled);
    downsampled->header = cloud->header;
    cloud = downsampled;

    // background subtraction and people detection
    auto filtered = backsub->filter(cloud);
    auto clusters = detector->detect(filtered);
    publish_msgs(points_msg->header.stamp, filtered, clusters);
    LOG(INFO) << "published filtered and clustered.";
  }

  void callback(const nav_msgs::OdometryConstPtr &odom_msg,
                const sensor_msgs::PointCloud2ConstPtr &points_msg) {
    LOG(INFO) << "got a point cloud...";
    if (!globalmap) {
      LOG(ERROR) << "globalmap has not been received!!";
      return;
    }

    pcl::PointCloud<PointT>::Ptr cloud(new pcl::PointCloud<PointT>());
    pcl::fromROSMsg(*points_msg, *cloud);
    if (cloud->empty()) {
      LOG(ERROR) << "cloud is empty!!";
      return;
    }

    // downsampling
    pcl::PointCloud<PointT>::Ptr downsampled(new pcl::PointCloud<PointT>());
    downsample_filter->setInputCloud(cloud);
    downsample_filter->filter(*downsampled);
    downsampled->header = cloud->header;
    cloud = downsampled;

    // transform #cloud into the globalmap space
    const auto &position = odom_msg->pose.pose.position;
    const auto &orientation = odom_msg->pose.pose.orientation;
    Eigen::Matrix4f transform = Eigen::Matrix4f::Identity();
    transform.block<3, 1>(0, 3) =
        Eigen::Vector3f(position.x, position.y, position.z);
    transform.block<3, 3>(0, 0) =
        Eigen::Quaternionf(orientation.w, orientation.x, orientation.y,
                           orientation.z)
            .toRotationMatrix();
    pcl::transformPointCloud(*cloud, *cloud, transform);
    cloud->header.frame_id = globalmap->header.frame_id;

    // background subtraction and people detection
    auto filtered = backsub->filter(cloud);
    auto clusters = detector->detect(filtered);
    publish_msgs(points_msg->header.stamp, filtered, clusters);
    LOG(INFO) << "published a detection result.";
  }

  void globalmap_callback(const sensor_msgs::PointCloud2ConstPtr &points_msg) {
    pcl::PointCloud<PointT>::Ptr cloud(new pcl::PointCloud<PointT>());
    pcl::fromROSMsg(*points_msg, *cloud);
    globalmap = cloud;

    double backsub_resolution =
        private_nh.param<double>("backsub_resolution", 0.2);
    int backsub_occupancy_thresh =
        private_nh.param<int>("backsub_occupancy_thresh", 2);

    backsub.reset(new BackgroundSubtractor());
    LOG(INFO) << "backsub should be a pointer?";
    backsub->setVoxelSize(backsub_resolution, backsub_resolution,
                          backsub_resolution);
    backsub->setOccupancyThresh(backsub_occupancy_thresh);
    backsub->setBackgroundCloud(globalmap);

    backsub_voxel_markers_pub.publish(backsub->create_voxel_marker());
    backsub_voxel_points_pub.publish(backsub->voxels());
  }

 private:
  void publish_msgs(const ros::Time &stamp,
                    const pcl::PointCloud<pcl::PointXYZI>::Ptr &filtered,
                    const std::vector<Cluster::Ptr> &clusters) const {
    if (clusters_pub.getNumSubscribers()) {
      cti_msgs::CloudClusterArrayPtr clusters_msg(
          new cti_msgs::CloudClusterArray());
      clusters_msg->header.frame_id = globalmap->header.frame_id;
      clusters_msg->header.stamp = stamp;
      clusters_msg->clusters.resize(clusters.size());

      for (int i = 0; i < clusters.size(); i++) {
        auto &cluster_msg = clusters_msg->clusters[i];
        cluster_msg.is_human = clusters[i]->is_human;
        cluster_msg.min_point.point.x = clusters[i]->min_pt.x();
        cluster_msg.min_point.point.y = clusters[i]->min_pt.y();
        cluster_msg.min_point.point.z = clusters[i]->min_pt.z();

        cluster_msg.max_point.point.x = clusters[i]->max_pt.x();
        cluster_msg.max_point.point.y = clusters[i]->max_pt.y();
        cluster_msg.max_point.point.z = clusters[i]->max_pt.z();

        cluster_msg.dimensions.x = clusters[i]->size.x();
        cluster_msg.dimensions.y = clusters[i]->size.y();
        cluster_msg.dimensions.z = clusters[i]->size.z();

        cluster_msg.centroid_point.point.x = clusters[i]->centroid.x();
        cluster_msg.centroid_point.point.y = clusters[i]->centroid.y();
        cluster_msg.centroid_point.point.z = clusters[i]->centroid.z();
      }
      clusters_pub.publish(clusters_msg);
    }
    if (backsub_points_pub.getNumSubscribers()) {
      backsub_points_pub.publish(filtered);
    }
    if (cluster_points_pub.getNumSubscribers()) {
      pcl::PointCloud<pcl::PointXYZI>::Ptr accum(
          new pcl::PointCloud<pcl::PointXYZI>());
      for (const auto &cluster : clusters) {
        std::copy(cluster->cloud->begin(), cluster->cloud->end(),
                  std::back_inserter(accum->points));
      }
      accum->width = accum->size();
      accum->height = 1;
      accum->is_dense = false;
      accum->header.stamp = filtered->header.stamp;
      accum->header.frame_id = globalmap->header.frame_id;
      cluster_points_pub.publish(accum);
    }
    if (human_points_pub.getNumSubscribers()) {
      pcl::PointCloud<pcl::PointXYZI>::Ptr accum(
          new pcl::PointCloud<pcl::PointXYZI>());
      for (const auto &cluster : clusters) {
        if (cluster->is_human) {
          std::copy(cluster->cloud->begin(), cluster->cloud->end(),
                    std::back_inserter(accum->points));
        }
      }
      accum->width = accum->size();
      accum->height = 1;
      accum->is_dense = false;
      accum->header.stamp = filtered->header.stamp;
      accum->header.frame_id = globalmap->header.frame_id;
      human_points_pub.publish(accum);
    }

          detection_markers_pub.publish(create_markers(stamp, clusters));
  }

  visualization_msgs::MarkerArrayConstPtr create_markers(
      const ros::Time &stamp, const std::vector<Cluster::Ptr> &clusters) const {
    visualization_msgs::MarkerArrayPtr markers(
        new visualization_msgs::MarkerArray());
    markers->markers.reserve(clusters.size());

    for (int i = 0; i < clusters.size(); i++) {
      if (!clusters[i]->is_human) {
        continue;
      }
      visualization_msgs::Marker cluster_marker;
      cluster_marker.header.stamp = stamp;
      cluster_marker.header.frame_id = globalmap->header.frame_id;
      cluster_marker.action = visualization_msgs::Marker::ADD;
      cluster_marker.lifetime = ros::Duration(0.5);
      cluster_marker.ns = (boost::format("cluster%d") % i).str();
      cluster_marker.type = visualization_msgs::Marker::CUBE;

      cluster_marker.pose.position.x = clusters[i]->centroid.x();
      cluster_marker.pose.position.y = clusters[i]->centroid.y();
      cluster_marker.pose.position.z = clusters[i]->centroid.z();
      cluster_marker.pose.orientation.w = 1.0;
      cluster_marker.color.r = 1.0;
      cluster_marker.color.g = 0.0;
      cluster_marker.color.b = 1.0;
      cluster_marker.color.a = 0.8;
      cluster_marker.scale.x = clusters[i]->size.x();
      cluster_marker.scale.y = clusters[i]->size.y();
      cluster_marker.scale.z = clusters[i]->size.z();
      markers->markers.push_back(cluster_marker);
    }
    return markers;
  }

 private:
  // ROS
  ros::NodeHandle nh;
  ros::NodeHandle mt_nh;
  ros::NodeHandle private_nh;

  // subscribers
  std::unique_ptr<message_filters::Subscriber<nav_msgs::Odometry>> odom_sub;
  std::unique_ptr<message_filters::Subscriber<sensor_msgs::PointCloud2>>
      points_sub;
  std::unique_ptr<message_filters::TimeSynchronizer<nav_msgs::Odometry, sensor_msgs::PointCloud2>> sync;
  ros::Subscriber globalmap_sub;
  ros::Subscriber static_points_sub;

  // publishers
  ros::Publisher backsub_points_pub;
  ros::Publisher backsub_voxel_points_pub;
  ros::Publisher cluster_points_pub;
  ros::Publisher human_points_pub;
  ros::Publisher detection_markers_pub;
  ros::Publisher backsub_voxel_markers_pub;
  ros::Publisher clusters_pub;
  pcl::PointCloud<PointT>::Ptr globalmap;
  pcl::Filter<PointT>::Ptr downsample_filter;
  std::unique_ptr<BackgroundSubtractor> backsub;
  std::unique_ptr<PeopleDetector> detector;
};

int main(int argc, char **argv) {
  ros::init(argc, argv, "abc");
  ros::NodeHandle nh;

  PersonDetectorNode *personDetNode = new PersonDetectorNode(nh);

  ros::Rate rater(10);
  while (ros::ok()) {
    ros::spinOnce();
  }
}