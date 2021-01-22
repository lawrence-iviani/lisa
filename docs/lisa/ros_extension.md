
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
$ mkdir -p ~/lisa_catkin_ws/src
$ cd ~/lisa_catkin_ws/
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
```

## Install dependecies

```batch
$ cd ~/lisa_catkin_ws/src
$ git clone https://github.com/ros/common_msgs.git
$ git clone https://github.com/ros/actionlib.git
$ git clone https://github.com/lawrence-iviani/lisa-interaction-msgs.git
$ git clone https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge.git
$ cd ..
$ catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3
# TODO: I have run also 
# $ catkin_make install -DPYTHON_EXECUTABLE=/usr/bin/python3
# Is this necessary?


# at this point it is necessary to run every time to select the environment. 
# could be added in .bashrc, eventually.
$ source devel/setup.bash

```

# Nodes Resource Monitor

An external tool to collect statistics about nodes usage
Some minor modification in a couple of conversion are needed 
[RobotnikAutomation system_monitor](https://github.com/RobotnikAutomation/system_monitor)

Used with rosbag to collect data and combined with an import 
[rosbag_pandas](https://github.com/eurogroep/rosbag_pandas)

Needed python packages in the host decoding the rosbag (e.g. virtual machine)

```
# pip3 install rospkg pycryptodomex python-gnupg rospy_message_converter
