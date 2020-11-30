

# RHASSPY

[Project](https://rhasspy.readthedocs.io/en/latest/) [github](https://github.com/rhasspy/rhasspy)

Several possibility are available, suggested for production is from [pre-compiled packages 32-bit and 64-bit](https://rhasspy.readthedocs.io/en/latest/installation/#debian)
Or for development with the [virtual-environment](https://rhasspy.readthedocs.io/en/latest/installation/#virtual-environment)

## Production
[Check for the latest avaialable binary](https://rhasspy.readthedocs.io/en/latest/installation/#debian)

```batch
# if not sure about the architecture, try
dpkg-architecture | grep DEB_BUILD_ARCH=

# Create a sw folder
mkdir sw
cd sw

# Latest version used 2.5.7, armhf. A arm64 is available
# https://github.com/rhasspy/rhasspy/releases/tag/v2.5.7
wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.7/rhasspy_2.5.7_armhf.deb
sudo apt install ./rhasspy_2.5.7_armhf.deb

```

## Install Docker
Needed to run some rhasspy nodes delivered for convenience as docker image.

```batch
curl -sSL https://get.docker.com | sh

# add your user the priviliegies
sudo usermod -a -G docker $USER
```
**Note: relogin to have access! Sometime a reboot is necessary.**

## Tmuxinator
Use tmuxinator to start stop session with all nodes, it exists a configuration file to run the entire solution from console.

* install [github-tmuxinator](https://github.com/tmuxinator/tmuxinator). 
```batch
# installed from repos though
sudo apt install tmuxinator
```

Copy the file in [home/pi/](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/home/pi/) 

```batch
tmux source ~/.tmux.conf
```

See [Run the solution](https://github.com/lawrence-iviani/lisa/blob/main/embedded/install.md#run-the-entire-solution)

## Development
[Check instructions here](https://rhasspy.readthedocs.io/en/latest/installation/#virtual-environment)
```batch

## You should have something like this installed. Sometimes install automatically.
sudo apt-get install  libatlas-base-dev swig supervisor mosquitto sox alsa-utils libgfortran4 espeak flite perl curl patchelf ca-certificates libttspico-utils

## Create a sw folder
# Note: most of the configuration are independent from the location, but some could fail
mkdir sw
cd sw

git clone --recursive https://github.com/rhasspy/rhasspy
cd rhasspy/

## Use one of the two options

# 1. Use the system environment
./configure --enable-in-place --disable-virtualenv  
# Note: possily some requirements has to be satisfied manually

# 2.  rhasspy run in virtual env
# probably it is necessary to change 
./configure   --disable-pocketsphinx  --disable-julius  --disable-wavenet  --disable-larynx    --disable-precise 

# for both
make
make install

```

## RHASSPY LISA ODAS HERMES

This is the module used inside the Rhasspy environment to acquire ODAS sources. 
ODAS provides tracked and localized sources with a beamforming techinque (when cloning use option --recurse-submodules)
See the README in [repos](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes)

### Development
TODO

## ROS
It is required to run a ROS node, see Lisa ROS Bridge

### INSTALL
Follow the guide in  [Installing ROS Melodic on the Raspberry Pi](http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi), and adding the support for python3. Follow all instructions for **ROS-Comm: (recommended)**
In general use the option -DPYTHON_EXECUTABLE=/usr/bin/python3 when using catkin_make

Furhter packages needed

```batch
$ sudo pip3 install  empy rospkg catkin_pkg  defusedxml netifaces roslibpy 
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

## Lisa ROS Bridge

In order to communicate with a ROS system a package named ROS bridge has been developed [lisa-mqtt-ros-bridge](https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge). It is based on 

### Create ROS workspace

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

### Install dependecies

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

## Lisa Led Manager

**TODO**
Component for Led management withing Hermes and Lisa via MQTT, in development.
See: [rhasspy-lisa-led-manager](https://github.com/lawrence-iviani/rhasspy-lisa-led-manager)
