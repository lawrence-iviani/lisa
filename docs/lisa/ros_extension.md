
# ROS
It is required to run a ROS node, see Lisa ROS Bridge

## INSTALL
Follow the guide in  [Installing ROS Melodic on the Raspberry Pi](http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi), and adding the support for python3. Follow all instructions for **ROS-Comm: (recommended)**
In general use the option -DPYTHON_EXECUTABLE=/usr/bin/python3 when using catkin_make

Furhter packages needed

```batch
$ sudo pip3 install  empy rospkg catkin_pkg  defusedxml netifaces roslibpy pycryptodomex python-gnupg
```

Create the workspace to build ROS on the system (another workspace has to be created for the application).

```batch
$ mkdir -p ~/ros_build/ros_build_catkin_ws
$ cd ~/ros_build/ros_build_catkin_ws
$ mkdir src
```

At this point install ROS in ```/opt/ros/melodic```, and it is compiled from source (it will take sometime)
```batch
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 --install-space /opt/ros/melodic

# With limited RAM reduce the number of processor and use the optin -j 2
```

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

## Nodes Resource Monitor

An external tool to collect statistics about nodes usage
Some minor modification in a couple of conversion are needed 
[RobotnikAutomation system_monitor](https://github.com/RobotnikAutomation/system_monitor)

Used with rosbag to collect data and combined with an import 
[rosbag_pandas](https://github.com/eurogroep/rosbag_pandas)

Needed python packages in the host decoding the rosbag (e.g. virtual machine)

```
# pip3 install rospkg pycryptodomex python-gnupg rospy_message_converter