#!/bin/bash

# This script is based on http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi

##############################
#### Configuration Option ####
##############################



##################################
#### End Configuration Option ####
##################################


cwd=$(pwd)

# Update system
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-get update 
sudo apt-get upgrade 

sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake
sudo rosdep init
rosdep update

# Noticed dependecies needed to work properly with pyhron (not in the help page)
sudo pip3 install  empy rospkg catkin_pkg  defusedxml netifaces roslibpy pycryptodomex python-gnupg


# Create a catkin Workspace for BUILD ROS!!! (not to be confused with the application WS!!!)

mkdir -p ~/hw/ros_build_catkin_ws
cd ~/hw/ros_build_catkin_ws

rosinstall_generator ros_comm --rosdistro melodic --deps --wet-only --tar > melodic-ros_comm-wet.rosinstall
wstool init src melodic-ros_comm-wet.rosinstall

# Dependecies
rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster

# Build

sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 --install-space /opt/ros/melodic
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc



cd $cwd