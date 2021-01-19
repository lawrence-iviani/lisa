
The complete list to install **LISA** from scratch on a Raspberry Pi (Pi4 with 2 GB is suggested)

# Embedded

## OS Installation

For image installation see [image installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/image.md)

## Pi Configuration

See [Pi setup](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/pi.md) 

## Microphone HATS

See [Audio HATS](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/audio_hat.md) 


# SW packages

## LISA 

Lisa is embodied as a concurrent systems of nodes using MQTT and the Hermes Protocol. A wrapper to interact with ROS systems is available.
An integration a further development of other open sources package, the most important:

* [ODAS](https://github.com/introlab/odas/wiki)
* [RHASSPY](https://rhasspy.readthedocs.io/en/latest/)
* [ROS](https://www.ros.org/)
* FlexBE

TODO: FIGURE 

### Installation

The following packages should be installed for setup lisa

* [Rhasspy](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/rhasspy_installation.md)
* [Lisa Hermes Wrapper](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/lisa.md)

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

## ROS

This Apply only for LISA with a ROS extension.



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
```




