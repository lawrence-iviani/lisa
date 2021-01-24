
# Lisa ROS Bridge

In order to communicate with a ROS system a package named ROS bridge has been developed [lisa-mqtt-ros-bridge](https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge). It is based on 

## Create ROS workspace

This system use python 3, users in ROS Melodic and earlier the first catkin_make command in a clean catkin workspace must be with the executable for python 3.

Run (or add to your .bashrc) the follow 

```batch
source /opt/ros/melodic/setup.bash
```

Adding the define -DPYTHON_EXECUTABLE=/usr/bin/python3 when calling catkin_make will configure the workspace with Python 3. You may then proceed to use just catkin_make for subsequent builds. 

```batch
$ mkdir -p ~/sw/lisa_catkin_ws/src
$ cd ~/sw/lisa_catkin_ws/
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
```

## Install dependecies

For python, better to setup the environment manually (it is not properly called with catkin (not sure where the problem is).

```batch
cd ~/sw/lisa_catkin_ws/src/lisa-mqtt-ros-bridge 
sudo pip3 setup.py install
```

```batch
cd ~/sw/lisa_catkin_ws/src
$ git clone https://github.com/ros/common_msgs.git
$ git clone https://github.com/ros/actionlib.git
$ git clone https://github.com/lawrence-iviani/lisa-interaction-msgs.git
$ git clone https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge.git
$ cd ..
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3

$ source devel/setup.bash

```

# Nodes Resource Monitor

_(optional)_

An external tool to collect statistics about nodes usage
Some minor modification in a couple of conversion are needed 
[RobotnikAutomation system_monitor](https://github.com/RobotnikAutomation/system_monitor)

Used with rosbag to collect data and combined with an import 
[rosbag_pandas](https://github.com/eurogroep/rosbag_pandas)

Needed python packages in the host decoding the rosbag (e.g. virtual machine)

```
# pip3 install rospkg pycryptodomex python-gnupg rospy_message_converter
