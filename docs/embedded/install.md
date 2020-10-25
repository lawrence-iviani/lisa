# HW and OS

## HW
**TODO: hw, power, case, speaker...**

## OS

For image installation see [image installation](https://github.com/lawrence-iviani/lisa/blob/main/embedded/image.md)

20201015: this guide is based on a Raspbian 32 bit armhf

## Setup The system

All what matters the raspberry and the basic package installation:
* pre-requisities
* development package 
* wifi
* hotspot
See (Pi setup)[https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/pi.md].

## AUDIO HAT 

Two audio hats are available:

* [MATRIX Voice Standard Version](https://store.matrix.one/products/matrix-voice)
* [ReSpeaker 4-Mic Array for Raspberry Pi](https://respeaker.io/4_mic_array/)

Details about the installation in [audio hat](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/audio_hat.md).

**Check the configuration of the board is set right.**
In order to making working, into the file [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) modify accordingly the line with one of the available hats:

```
Inside cfg, adapt the following line

odas_config = lisa-odas/config/lisa/CFG

Where CFG = lisa_matrix.cfg || respeaker_4_mic_array.cfg
```

# SW

Lisa is embodied as a concurrent systems of nodes using MQTT and the Hermes Protocol. A wrapper to interact with ROS systems is available.
An integration a further development of other open sources package, the most important:

* [ODAS](https://github.com/introlab/odas/wiki)
* [RHASSPY](https://rhasspy.readthedocs.io/en/latest/)
* [ROS](https://www.ros.org/)

See the installation details in page [lisa node installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/lisa_node_installation.md) for making it up and running.

## Configuration

All files can be copied with a script. Both directions are possible, in installation we are interested in copy from the repos to the lisa embedded installation.

```batch
# cd to the root location of the package conatining this file
$ cd path-to-lisa
$ cd scripts
$ python3 copy_util.py --to_lisa 
```

* At 20201025: no alsa conf files are copied. These must be copied manually accordingly to your Audio HAT.
* At 20201025: no configuration of the hat odas.cfg is performed.

# Run the entire solution

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
