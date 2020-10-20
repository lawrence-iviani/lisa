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

# more update version could be available, develpoed with this version
wget https://github.com/rhasspy/rhasspy/releases/download/v2.5.0/rhasspy_2.5.0_armhf.deb
sudo apt install ./rhasspy_2.5.0_armhf.deb

```

### Tmuxinator
Use tmuxinator to start stop session with all nodes, it exists a configuration file to run the entire solution from console.

* install [github-tmuxinator](https://github.com/tmuxinator/tmuxinator).

* Copy the files in pi/config [all for Matrix Voice](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/home/pi/config)
This is normally in ~/.config/tmuxinator (please notice as .config is a hidden folder)

Enjoy, simply use:

```batch
$ tmuxinator start lisa_rhasspy_full_start.yml
```

### Development
[Check instructions here](https://rhasspy.readthedocs.io/en/latest/installation/#virtual-environment)
```batch

sudo apt-get install  libatlas-base-dev swig supervisor mosquitto sox alsa-utils libgfortran4 espeak flite perl curl patchelf ca-certificates libttspico-utils

# Install libttspico abd libttspico-utils
# if apt-get fails, it has to be done manually
mkdir deb
cd deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb
apt-get install -f ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb
cd ~

# Create a sw folder
mkdir dev
cd dev

git clone --recursive https://github.com/rhasspy/rhasspy
cd rhasspy/

# Use one of the two options
# rhasspy run in virtual env
./configure --enable-in-place  --disable-julius --disable-precise


# Rhasspy shares the environment
./configure --enable-in-place  --disable-julius --disable-precise --disable-virtualenv

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
```


## Lisa ROS Bridge
https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge
