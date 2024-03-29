#include <mutex>
#include <memory>
#include <iostream>
#include <boost/format.hpp>

#include <ros/ros.h>
#include <pcl_ros/point_cloud.h>
#include <tf_conversions/tf_eigen.h>
#include <tf/transform_broadcaster.h>

#include <pcl/filters/filter.h>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <pluginlib/class_list_macros.h>

#include <visualization_msgs/MarkerArray.h>
#include <cti_msgs/TrackArray.h>
#include "cti_msgs/Track.h"
#include <cti_msgs/CloudClusterArray.h>

#include <kkl/cvk/cvutils.hpp>
#include <hdl_people_tracking/people_tracker.hpp>
#include "glog/logging.h"


using namespace google;



namespace hdl_people_tracking {
class PersonTrackingNode {
public:
  using PointT = pcl::PointXYZI;

  PersonTrackingNode(ros::NodeHandle nh) {
    LOG(INFO) << "starting tracking node....";
    private_nh = nh;
    tracker.reset(new PeopleTracker(private_nh));
    color_palette = cvk::create_color_palette(16);
    tracks_pub = private_nh.advertise<cti_msgs::TrackArray>("tracks", 10);
    marker_pub = private_nh.advertise<visualization_msgs::MarkerArray>("markers", 10);
    clusters_sub = nh.subscribe("/cti/perception/clusters", 1, &PersonTrackingNode::callback, this);
  }

  virtual ~PersonTrackingNode() {}


private:

  void callback(const cti_msgs::CloudClusterArrayPtr& clusters_msg) {
    LOG(INFO) << "got " << clusters_msg->clusters.size() << " clusters";
    // remove non-human detections
    auto remove_loc = std::remove_if(clusters_msg->clusters.begin(), clusters_msg->clusters.end(), [=](const cti_msgs::CloudCluster& cluster) {
      return !cluster.is_human;
    });
    clusters_msg->clusters.erase(remove_loc, clusters_msg->clusters.end());

    // update people tracker
    tracker->predict(clusters_msg->header.stamp);
    tracker->correct(clusters_msg->header.stamp, clusters_msg->clusters);

    // publish tracks msg
    if(tracks_pub.getNumSubscribers()) {
      tracks_pub.publish(create_tracks_msg(clusters_msg->header));
    }

    // publish rviz markers
    if(marker_pub.getNumSubscribers()) {
      marker_pub.publish(create_tracked_people_marker(clusters_msg->header));
    }
  }

  cti_msgs::TrackArrayConstPtr create_tracks_msg(const std_msgs::Header& header) const {
    // we need to calculate speed of every track id
    // by record last tracked object position
    cti_msgs::TrackArrayPtr tracks_msg(new cti_msgs::TrackArray());
    tracks_msg->header = header;
    tracks_msg->tracks.resize(tracker->people.size());
    for(int i=0; i<tracker->people.size(); i++) {
      const auto& track = tracker->people[i];
      auto& track_msg = tracks_msg->tracks[i];

      track_msg.id = track->id();
      track_msg.age = (track->age(header.stamp)).toSec();
      track_msg.pos.x = track->position().x();
      track_msg.pos.y = track->position().y();
      track_msg.pos.z = track->position().z();
      track_msg.vel.x = track->velocity().x();
      track_msg.vel.y = track->velocity().y();
      track_msg.vel.z = track->velocity().z();
      track_msg.vel_rel = track->velocity_relative();

      Eigen::Matrix3d pos_cov = track->positionCov();
      for(int k=0; k<3; k++) {
        for(int j=0; j<3; j++) {
          track_msg.pos_cov[k*3 + j] = pos_cov(k, j);
        }
      }

      Eigen::Matrix3d vel_cov = track->velocityCov();
      for(int k=0; k<3; k++) {
        for(int j=0; j<3; j++) {
          track_msg.vel_cov[k*3 + j] = vel_cov(k, j);
        }
      }

      const cti_msgs::CloudCluster* associated = boost::any_cast<cti_msgs::CloudCluster>(&track->lastAssociated());
      if(!associated) {
        continue;
      }
      track_msg.associated.resize(1);
      track_msg.associated[0] = (*associated);
    }
    return tracks_msg;
  }

  visualization_msgs::MarkerArrayConstPtr create_tracked_people_marker(const std_msgs::Header& header) const {
    visualization_msgs::MarkerArrayPtr markers_ptr(new visualization_msgs::MarkerArray());
    // how to show and visualize a trace
    visualization_msgs::MarkerArray& markers = *markers_ptr;
    markers.markers.reserve(tracker->people.size() + 1);
    markers.markers.resize(1);

    visualization_msgs::Marker& boxes = markers.markers[0];
    boxes.header = header;
    boxes.action = visualization_msgs::Marker::ADD;
    boxes.lifetime = ros::Duration(1.0);

    boxes.ns = "boxes";
    boxes.type = visualization_msgs::Marker::CUBE_LIST;
    boxes.colors.reserve(tracker->people.size());
    boxes.points.reserve(tracker->people.size());

    boxes.pose.position.z = 0.0f;
    boxes.pose.orientation.w = 1.0f;

    boxes.scale.x = 0.5;
    boxes.scale.y = 0.5;
    boxes.scale.z = 1.2;

    for(int i=0; i<tracker->people.size(); i++) {
      const auto& person = tracker->people[i];
      const auto& color = color_palette[person->id() % color_palette.size()];

      if(person->correctionCount() < 5) {
        continue;
      }

      std_msgs::ColorRGBA rgba;
      rgba.r = color[2] / 255.0;
      rgba.g = color[1] / 255.0;
      rgba.b = color[0] / 255.0;
      rgba.a = 0.6f;
      markers.markers[0].colors.push_back(rgba);

      geometry_msgs::Point point;
      point.x = person->position().x();
      point.y = person->position().y();
      point.z = person->position().z();
      markers.markers[0].points.push_back(point);

      visualization_msgs::Marker text;
      text.header = markers.markers[0].header;
      text.action = visualization_msgs::Marker::ADD;
      text.lifetime = ros::Duration(1.0);

      text.ns = (boost::format("text%d") % person->id()).str();
      text.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
      text.scale.z = 0.5;

      text.pose.position = point;
      text.pose.position.z += 0.7;
      text.color.r = text.color.g = text.color.b = text.color.a = 1.0;
      text.text = (boost::format("ID: %d v: %3.3fm/s") % person->id() % person->velocity_relative()).str();
      markers.markers.push_back(text);
    }

    return markers_ptr;
  }

private:
  // ROS
  ros::NodeHandle nh;
  ros::NodeHandle mt_nh;
  ros::NodeHandle private_nh;

  ros::Publisher tracks_pub;
  ros::Publisher marker_pub;
  ros::Subscriber clusters_sub;

  boost::circular_buffer<cv::Scalar> color_palette;
  std::unique_ptr<PeopleTracker> tracker;
};
}

int main(int argc, char** argv) {
  ros::init(argc, argv, "abc");
  ros::NodeHandle nh;
  ros::NodeHandle pn("~");

  hdl_people_tracking::PersonTrackingNode personTracking(pn);

  ros::Rate rate(10);
  while (ros::ok()) {
    rate.sleep();
    ros::spin();
  }
}


