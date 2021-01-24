
The complete list to install **LISA** from scratch on a Raspberry Pi (Pi4 with 2 GB is suggested)

# Embedded

## OS Installation

For image installation see [image installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/image.md)

## Pi Configuration

See [Pi setup](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/pi.md) 

## Microphone HATS

For instructions See [Audio HATS](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/audio_hat.md) 

The following HATS are supported, others should be easily implemented:

* [Matrix Voice](https://matrix-io.github.io/matrix-documentation/matrix-voice/overview/)
![Matrix](https://matrix-io.github.io/matrix-documentation/matrix-voice/img/m-2.png)

* [Respeaker Square Array 4 mics](https://wiki.seeedstudio.com/ReSpeaker_4_Mic_Array_for_Raspberry_Pi/)
![Squared Array Reaspeaker](https://files.seeedstudio.com/wiki/ReSpeaker-4-Mic-Array-for-Raspberry-Pi/img/overview.jpg)

* [Respeaker Linear Array 4 mics](https://wiki.seeedstudio.com/ReSpeaker_4-Mic_Linear_Array_Kit_for_Raspberry_Pi/)
![Linear Array Reaspeaker](https://files.seeedstudio.com/wiki/ReSpeaker_4-Mics_Linear_Array_Kit/img/main_wiki.jpg)




# SW packages

## ROS

This is a guide to install ROS Meolodic on a raspbbery and it is derived from a ROS guide.
* [ROS on Raspberry](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/ros_pi.md)



## LISA 

Lisa is embodied as a concurrent systems of nodes using MQTT and the Hermes Protocol. A wrapper to interact with ROS systems is available.
An integration a further development of other open sources package, the most important:

* [ODAS](https://github.com/introlab/odas/wiki)
* [RHASSPY](https://rhasspy.readthedocs.io/en/latest/)
* [ROS](https://www.ros.org/)
* [FlexBE](http://wiki.ros.org/flexbe)


![LISA SW subsytem](https://github.com/lawrence-iviani/lisa/blob/main/img/SYSML%20SW%20Block.png)

### Installation

The following packages should be installed for setup lisa

* [Rhasspy](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/rhasspy_installation.md)
* [Lisa Hermes Wrapper](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/lisa.md)
* [Lisa Led Manager](https://github.com/lawrence-iviani/rhasspy-lisa-led-manager)


The following packages should be installed for setup lisa with a ROS extension and FlexBE status
* [ROS Extension](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/ros_extension.md)

Old installation details in page [lisa node installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/old_nodes_installation.md) for making it up and running.

### Configuration

All files can be copied with a script. Both directions are possible, in installation we are interested in copy from the repos to the lisa embedded installation.

```batch
# cd to the root location of the package conatining this file
$ cd path-to-lisa
$ cd scripts
$ python3 copy_util.py --to_lisa 
```

**At 20210119: no alsa conf files are copied. These must be copied manually accordingly to your Audio HAT.**
See [Audio HATS](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/audio_hat.md) 


**At 20210119: link for supported profiles in rhasspy working directory are not created (rqt and Motek_2018).** For this reason rhasspy will fail to load at a startup. 
_TODO: need for explanation_

# Run

* Be sure you have installed Tmuxinator, see See [install tmuxinator](https://github.com/lawrence-iviani/lisa/blob/main/embedded/install.md#tmuxinator)

* Copy the files in [pi/.config](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/home/pi/config)
This is normally in ~/.config/tmuxinator (please notice as .config is a hidden folder) and copied with the configuration script.

* Check the asound.conf is the correct for your HAT and  [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) is pointing to the right ODAS configuration.

Enjoy, simply use:

```batch
# With LISA_PLATFORM one of the supported boards (Matrix Voice, Respeaker 4 Mic)
# With LISA_LED_PATTERN one of the supported led patterns (GoogleHome, Amazon). These are imitations from [4MICs HAT for Raspberry Pi](https://github.com/respeaker/4mics_hat)
$ tmuxinator start lisa_rhasspy_full_start.yml  --hw-board LISA_PLATFORM --led-pattern LISA_LED_PATTERN

# in ~ a lisa_start.sh and lisa_stop.sh are used for quick start
$ cd ~
$ ./lisa_start.sh help
Usage: ./lisa_start [help] || [session_name=TMUX_SESSION] [platform=BOARD] [led_pattern=LED_PATTERN] [ros_master=ROS_MASTER_IP]  [rhasspy_profile=RHASSPY_PROFILE]
                help: print this help and exit.
                TMUX_SESSION: lisa_rhasspy_full_start|lisa_rhasspy_full_start_LAB (Optional)
                BOARD: Respeaker4MicArray|MatrixVoice|DummyBoard (Optional)
                LED_PATTERN: GoogleHome|Alexa (Optional)
                ROS_MASTER_IP: the ip of the ros master to connect, in the form ip:port (e.g 192.168.0.104:11311)
                RHASSPY_PROFILE: the name of the rhasspy profile to load (deafault is en, at the moment rqt and Motek_2018 are possible candidates)


```




