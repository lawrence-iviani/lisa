# Full installation guide

**In Consolidation**:  at the moment this part is under construction with consolidated information!

* [Full Installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/install.md)

# Quick Start

**EXPERIMENTAL**: the follow instructions should work but small adjustments possibly are required!
Please not also there are several possibilities in configure the installation, but not all are verified!

## Setup Embedded
Setup your system with Pi configuration as described in:
* [Install the image](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/image.md)
* Or download an image from here TODO: add image
* Typically you want Resize the SD, activate wifi (this if you need to access as hotspot Lisa), set network if default is not an option [see configure pi](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/pi.md#configure-the-raspberry)

Set up git and get the lisa main repository

```batch
sudo apt-get -y install git
cd ~
git clone https://github.com/lawrence-iviani/lisa.git
cd lisa/scripts

# Change the comnfiguration variable at the top of the script 
./install_pi.sh

# You have to reboot and in some case still do some manual further step (e.g. Matrix Boards)
# Check the output of the script!

```
Available option (at the moment must be selected inside the script), are:

* **install_wifi**=_true|false_, if you want to access the system via wifi. (useful if the wired network within the application system and is not available )
* **hardware**=_"respeaker_4mic_linear" | "respeaker_4mic" | "matrix_voice"_ Select one of the possible mic HATS hw. This will configure the hw as well.

But remeber **Check the output of the script!**

## Setup ROS Environment
This is required to enable LISA to dialogue with an external ROS middleware. No configuration. Destination folder are embedded in the script.
The build workspace is isolated and built in _~/hw/ros_build_catkin_ws_

[Based on ROS guide, Melodic on Raspberry Pi](http://wiki.ros.org/ROSberryPi/Installing%20ROS%20Melodic%20on%20the%20Raspberry%20Pi)


```batch
cd ~
cd lisa/scripts
./install_ros.sh
```

## Setup LISA
_Note: this will configure only the **en** profile with  a number of intents and slots developed for KolRob_

```batch
cd ~
cd lisa/scripts
./install_lisa.sh
```

Option

* **hardware**, see installation of Embedded. Same options. Here used to configure the beam former (a manual step is still necessary). This must be the same of pi installation script!
* **rh_binaries**=true,  binaries downloaded from Rhasspy repository 
	* **rh_binaries_version** at the moment 2.5.9
	* arch="armhf". Hardware float 32 bit. Change accordingly to the architecture (consider switch to 64 bits when hats kernel modules & C. are availabe)
* **rh_binaries**=false,  download the RH package and make it
	* **virtual_env**=false|true,  note, with true seems not working, a weird issue in pip requriments management in RH (possibly a bug>).
	* **rh_tag_branch**="v2.5.7",  check rh branches on [rh github](https://github.com/rhasspy/rhasspy)

**TIP:** the only option should be **rh_binaries**  binary true|false and update of the versions. Hardware has to be selected compatible with the installed HATS.

## Setup LISA ROS extensions

Assuming ROS is properly installed run the script below. No configuration available, the solution will build the lisa catkin workspace in _~/sw/lisa_catkin_ws_

```batch
cd ~
cd lisa/scripts
./install_lisa_ros.sh
```

## References


**OBSOLETE**: this is the original page, which contains links and idea but is not updated!!!!
All the steps are cosolidated in scripts and explained (still on going!!) in the install page mentioned at the top.

Reference [Install the LISA system and dependecies](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/old_nodes_installation.md)
