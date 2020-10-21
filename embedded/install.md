# EMBEDDED

## OS

For image installation see [installation see ](https://github.com/lawrence-iviani/lisa/blob/main/embedded/image.md)

20201015: this guide is based on a Raspbian 32 bit armhf

## Setup The system

### First Run, configure the Raspberry

**Find the Pi**
Well, there can be a number of possibility. 
I use a tool like [Advanced IP Scanner](https://www.advanced-ip-scanner.com/)

**Configure Pi**
SSH to the IP found in the step before, with your preferred tool.
Default credentials for a raspberry
*User:* pi
*password:* raspbian

**Configure the raspberry**
[sudo raspi-config](https://www.raspberrypi.org/documentation/configuration/raspi-config.md )

* Resized SD
* wlan (if you consider to use wifi)
* Network (optional, if default DHCP is fine for you)

### Bashrc

In .bashrc, I usually enable:
```batch
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
```

### Update the embedded OS

```batch
sudo apt-get update
sudo apt-get upgrade

# install git 
sudo apt-get install git 

# Building tools
sudo apt-get install cmake vim

# install other dependencies library 
sudo apt-get install  python3 python3-pip python3-setuptools python3-yaml libfftw3-3

# Development tools
# Install only if you consider to develop an application
sudo apt-get install python3 python3-dev  python3-venv  sox alsa-utils build-essential portaudio19-dev  libfftw3-dev libconfig-dev  libjson-c-dev

```

### Setup a hotspot wireless
This is useful to control the board when the wired is busy in an [un-accessible network](https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md)

* The Wireless is set as static access point in the network 10.0.0.1/24 (Type C, 254 addresses)
* The DHCP is set to serve address from 10.0.0.2/20
* address is /lisa.wlan  or 10.0.0.1

```batch

# In order to work as an access point, the Raspberry Pi needs to have the hostapd access point software package installed:

sudo apt install hostapd

# Enable the wireless access point service and set it to start when your Raspberry Pi boots:

sudo systemctl unmask hostapd
sudo systemctl enable hostapd

# In order to provide network management services (DNS, DHCP) to wireless clients, the Raspberry Pi needs to have the dnsmasq software package installed:

sudo apt install dnsmasq

# Finally, install netfilter-persistent and its plugin iptables-persistent. This utilty helps by saving firewall rules and restoring them when the Raspberry Pi boots:

sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
```
**Config File**
Adjust based on your configuration the following file in [\etc\]([etc for 4-Mic Array](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/etc)):

* /etc/dhcpcd.conf
* /etc/dnsmasq.conf
* /etc/sysctl.d/routed-ap.conf
* /etc/hostapd/hostapd.conf

**WiFi Network**
In the file /etc/hostapd/hostapd.conf it is possible to set name and password of the access point.

* SSID: Lisa.wlan (this is also the address of the bot)
* password: L1sa@sc0lTa

## AUDIO HAT 

Two audio hats are available:

* [MATRIX Voice Standard Version](https://store.matrix.one/products/matrix-voice)
* [ReSpeaker 4-Mic Array for Raspberry Pi](https://respeaker.io/4_mic_array/)

Only one should be installed. In order to making working, into the file [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) modify accordingly the line with one of the available hats:

odas_config = lisa-odas/config/lisa//lisa_matrix.cfg || lisa-odas/config/lisa/respeaker_4_mic_array.cfg


### Install Matrix Software

Note: As first snippet I have started from this hack on [hackster](https://www.hackster.io/matrix-labs/direction-of-arrival-for-matrix-voice-creator-using-odas-b7a15b)

```batch
# Add repo and key
curl https://apt.matrix.one/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.matrix.one/raspbian $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/matrixlabs.list

# Update packages and install
sudo apt-get update
sudo apt-get upgrade

# Installation
sudo apt install matrixio-creator-init
sudo apt install libmatrixio-creator-hal
sudo apt install libmatrixio-creator-hal-dev
sudo reboot

```

* After reboot, install the MATRIX Kernel Modules as follows:

**Install**
Copy the files in your embedded system  [etc for Matrix Voice](https://github.com/lawrence-iviani/lisa/tree/main/configuration/Matrix%20Voice/etc)

```batch
sudo apt install matrixio-kernel-modules
sudo reboot
```

**Remeber to copy the [ALSA asound.conf file](https://github.com/lawrence-iviani/lisa/blob/main/configuration/Matrix_Voice/etc/asound.conf) in /etc/**

### ReSpeaker 4-Mic Array for Raspberry Pi

Copy the files in your embedded system  [etc for 4-Mic Array](https://github.com/lawrence-iviani/lisa/tree/main/configuration/Respaker%204%20mic/etc)
[getting-started](https://wiki.seeedstudio.com/ReSpeaker_4_Mic_Array_for_Raspberry_Pi/#getting-started)


```batch
# update the system
sudo apt-get update 
sudo apt-get upgrade 

# Installation
mkdir hw
cd hw
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh
sudo reboot

# for the led control
sudo pip3 install spidev gpiozero

# If you wanna try out
cd hw
git clone https://github.com/respeaker/4mics_hat.git
cd /home/pi/4mics_hat

# some packages like numpy has probably to be installed
# sudo apt-get install libatlas-base-dev
python pixels_demo.py
```


**Remeber to copy the [ALSA asound.conf file](https://github.com/lawrence-iviani/lisa/blob/main/configuration/Respeaker_4mic_array/etc/asound.conf) in /etc/**

---------------

# SW

## RHASSPY

[Project](https://rhasspy.readthedocs.io/en/latest/) [github](https://github.com/rhasspy/rhasspy)

Several possibility are available, suggested for production is from [pre-compiled packages 32-bit and 64-bit](https://rhasspy.readthedocs.io/en/latest/installation/#debian)
Or for development with the [virtual-environment](https://rhasspy.readthedocs.io/en/latest/installation/#virtual-environment)

### Production
[Check for the latest avaialable binary](https://rhasspy.readthedocs.io/en/latest/installation/#debian)

```batch
# if not sure about the architecture
dpkg-architecture | grep DEB_BUILD_ARCH=

# Create a sw folder
mkdir sw
cd sw

# more update version could be available, develpoed with this version and 2.5.7 at a later stage
wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.0/rhasspy_2.5.0_armhf.deb
sudo apt install ./rhasspy_2.5.0_armhf.deb

```

### Install Docker

Needed to run some rhasspy nodes delivered for convenience as docker image.

```batch
curl -sSL https://get.docker.com | sh

# add your user the priviliegies
sudo usermod -a -G docker $USER
```
**Note: relogin to have access! Sometime a reboot is necessary.**

### Tmuxinator
Use tmuxinator to start stop session with all nodes, it exists a configuration file to run the entire solution from console.

* install [github-tmuxinator](https://github.com/tmuxinator/tmuxinator). 
```batch
# installed from repos though
sudo apt install tmuxinator
```

Copy the file in [home/pi/](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/home/pi/) and run at least once to configure tmux (not sure why is not loaded at runtime)

```batch
tmux source ~/.tmux.conf
```

See [Run the solution](https://github.com/lawrence-iviani/lisa/blob/main/embedded/install.md#run-the-entire-solution)

### Development
[Check instructions here](https://rhasspy.readthedocs.io/en/latest/installation/#virtual-environment)
```batch

## You should have something like this installed. Sometimes install automatically.
sudo apt-get install  libatlas-base-dev swig supervisor mosquitto sox alsa-utils libgfortran4 espeak flite perl curl patchelf ca-certificates libttspico-utils

## Install libttspico abd libttspico-utils, if apt-get fails, it has to be done manually
mkdir deb
cd deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb
apt-get install -f ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb
cd ~

## Create a sw folder
mkdir sw
cd sw

git clone --recursive https://github.com/rhasspy/rhasspy
cd rhasspy/

## Use one of the two options
# rhasspy run in virtual env
./configure  --disable-julius --disable-precise

# Use the system environment
./configure --enable-in-place  --disable-julius --disable-precise --disable-virtualenv
# In this case all the requirements must be satisfied manually

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

---------------
# Run the entire solution

* Be sure you have installed Tmuxinator, see See [install tmuxinator](https://github.com/lawrence-iviani/lisa/blob/main/embedded/install.md#tmuxinator)

* Copy the files in [pi/.config](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/home/pi/config)
This is normally in ~/.config/tmuxinator (please notice as .config is a hidden folder)

* Check the asound.conf is the correct for your HAT and  [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) is pointing to the right ODAS configuration.

Enjoy, simply use:

```batch
$ tmuxinator start lisa_rhasspy_full_start.yml
```
