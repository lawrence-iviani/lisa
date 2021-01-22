
# ROS
It is required to run a ROS node, see Lisa ROS Bridge

## INSTALL
Follow the guide in  [Installing ROS Melodic on the Raspberry Pi](http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi), and adding the support for python3. Follow all instructions for **ROS-Comm: (recommended)**
In general use the option -DPYTHON_EXECUTABLE=/usr/bin/python3 when using catkin_make

Install ROS repository, packages needed and update

```batch
$ sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
$ sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

$ sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake

$ sudo apt-get update 
$ sudo apt-get upgrade 

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
$ rosinstall_generator ros_comm --rosdistro melodic --deps --wet-only --tar > melodic-ros_comm-wet.rosinstall
$ wstool init src melodic-ros_comm-wet.rosinstall

# Dependecies
$ rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster

# Build

$ sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 --install-space /opt/ros/melodic
# With limited RAM reduce the number of processor and use the optin -j 2

$ echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

```

