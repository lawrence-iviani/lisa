#!/bin/bash

# This script is based on http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi

##############################
#### Configuration Option ####
##############################



##################################
#### End Configuration Option ####
##################################


cwd=$(pwd)

mkdir -p ~/sw/lisa_catkin_ws/src
cd ~/sw/lisa_catkin_ws/
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

cd ./src
git clone https://github.com/ros/common_msgs.git
git clone https://github.com/ros/actionlib.git
git clone https://github.com/lawrence-iviani/lisa-interaction-msgs.git
git clone https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge.git
cd ..
catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

source devel/setup.bash

cd $cwd