# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "hdl_people_tracking: 4 messages, 0 services")

set(MSG_I_FLAGS "-Ihdl_people_tracking:/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(hdl_people_tracking_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_custom_target(_hdl_people_tracking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hdl_people_tracking" "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" "geometry_msgs/Point:hdl_people_tracking/Cluster:geometry_msgs/Vector3"
)

get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_custom_target(_hdl_people_tracking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hdl_people_tracking" "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" "geometry_msgs/Point:geometry_msgs/Vector3"
)

get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_custom_target(_hdl_people_tracking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hdl_people_tracking" "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" "geometry_msgs/Vector3:std_msgs/Header:hdl_people_tracking/Cluster:geometry_msgs/Point"
)

get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_custom_target(_hdl_people_tracking_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "hdl_people_tracking" "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" "geometry_msgs/Vector3:hdl_people_tracking/Track:std_msgs/Header:hdl_people_tracking/Cluster:geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_cpp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_cpp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_cpp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
)

### Generating Services

### Generating Module File
_generate_module_cpp(hdl_people_tracking
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(hdl_people_tracking_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(hdl_people_tracking_generate_messages hdl_people_tracking_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_cpp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_cpp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_cpp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_cpp _hdl_people_tracking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hdl_people_tracking_gencpp)
add_dependencies(hdl_people_tracking_gencpp hdl_people_tracking_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hdl_people_tracking_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_eus(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_eus(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_eus(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
)

### Generating Services

### Generating Module File
_generate_module_eus(hdl_people_tracking
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(hdl_people_tracking_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(hdl_people_tracking_generate_messages hdl_people_tracking_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_eus _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_eus _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_eus _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_eus _hdl_people_tracking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hdl_people_tracking_geneus)
add_dependencies(hdl_people_tracking_geneus hdl_people_tracking_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hdl_people_tracking_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_lisp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_lisp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_lisp(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
)

### Generating Services

### Generating Module File
_generate_module_lisp(hdl_people_tracking
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(hdl_people_tracking_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(hdl_people_tracking_generate_messages hdl_people_tracking_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_lisp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_lisp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_lisp _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_lisp _hdl_people_tracking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hdl_people_tracking_genlisp)
add_dependencies(hdl_people_tracking_genlisp hdl_people_tracking_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hdl_people_tracking_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_nodejs(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_nodejs(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_nodejs(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
)

### Generating Services

### Generating Module File
_generate_module_nodejs(hdl_people_tracking
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(hdl_people_tracking_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(hdl_people_tracking_generate_messages hdl_people_tracking_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_nodejs _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_nodejs _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_nodejs _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_nodejs _hdl_people_tracking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hdl_people_tracking_gennodejs)
add_dependencies(hdl_people_tracking_gennodejs hdl_people_tracking_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hdl_people_tracking_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_py(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_py(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
)
_generate_msg_py(hdl_people_tracking
  "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
)

### Generating Services

### Generating Module File
_generate_module_py(hdl_people_tracking
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(hdl_people_tracking_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(hdl_people_tracking_generate_messages hdl_people_tracking_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Track.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_py _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/Cluster.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_py _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/ClusterArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_py _hdl_people_tracking_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/media/jintian/data/catkin_ws/src/perception/lidar/lidar_detector/person_tracking/msg/TrackArray.msg" NAME_WE)
add_dependencies(hdl_people_tracking_generate_messages_py _hdl_people_tracking_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(hdl_people_tracking_genpy)
add_dependencies(hdl_people_tracking_genpy hdl_people_tracking_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS hdl_people_tracking_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/hdl_people_tracking
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(hdl_people_tracking_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(hdl_people_tracking_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/hdl_people_tracking
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(hdl_people_tracking_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(hdl_people_tracking_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/hdl_people_tracking
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(hdl_people_tracking_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(hdl_people_tracking_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/hdl_people_tracking
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(hdl_people_tracking_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(hdl_people_tracking_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/hdl_people_tracking
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(hdl_people_tracking_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(hdl_people_tracking_generate_messages_py geometry_msgs_generate_messages_py)
endif()
