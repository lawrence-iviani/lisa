
# AUDIO HAT 

Two audio hats are available:

* [MATRIX Voice Standard Version](https://store.matrix.one/products/matrix-voice)
* [ReSpeaker 4-Mic Array for Raspberry Pi](https://respeaker.io/4_mic_array/)

Only one should be installed. In order to making working, into the file [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) modify accordingly the line with one of the available hats:

odas_config = lisa-odas/config/lisa//lisa_matrix.cfg || lisa-odas/config/lisa/respeaker_4_mic_array.cfg


## Install Matrix Software

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

VERY IMPORTANT: 
**Remeber to copy the [ALSA asound.conf file](https://github.com/lawrence-iviani/lisa/blob/main/configuration/Matrix_Voice/etc/asound.conf) in /etc/**

## ReSpeaker 4-Mic Array for Raspberry Pi

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


**Check the configuration of the board is set right.**
VERY IMPORTANT: 
**Remeber to copy the [ALSA asound.conf file](https://github.com/lawrence-iviani/lisa/blob/main/configuration/Respeaker_4mic_array/etc/asound.conf) in /etc/**

## ReSpeaker 4-Mic Array for Raspberry Pi

Copy the files in your embedded system  TODO [NOT UPDATED](https://github.com/lawrence-iviani/lisa/tree/main/configuration/Respaker%204%20mic/etc)
[getting-started](https://wiki.seeedstudio.com/ReSpeaker_4-Mic_Linear_Array_Kit_for_Raspberry_Pi/#software)


```batch
sudo apt-get update
sudo apt-get upgrade
git clone https://github.com/respeaker/seeed-voicecard.git
cd seeed-voicecard
sudo ./install.sh  
sudo reboot
```

# ODAS

This is relevant for the beamforming platform ODAS. Similar to the alsa file also the ODAS file must be adapted with the proper hw platform.

In order to making working, into the file [lisa.cfg](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes/blob/master/rhasspy_lisa_odas_hermes/config/lisa.cfg) modify accordingly the line with one of the available hats:

```
Inside cfg, adapt the following line

odas_config = lisa-odas/config/lisa/CFG

Where CFG = lisa_matrix.cfg || respeaker_4_mic_array.cfg
```

