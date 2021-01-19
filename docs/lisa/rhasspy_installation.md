

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
