



# RHASSPY LISA ODAS HERMES

This is the module used inside the Rhasspy environment to acquire ODAS sources. 
ODAS provides tracked and localized sources with a beamforming techinque (when cloning use option --recurse-submodules)
See the README in [repos](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes)

## Dependecies


### Rhasspy environment
#### Development

```batch
	# install dep
	sudo apt-get -y install portaudio19-dev libatlas-base-dev swig 
	
	## You should have something like this installed. Sometimes install automatically.
	# sudo apt-get -y install  libatlas-base-dev swig supervisor mosquitto sox alsa-utils libgfortran4 espeak flite perl curl patchelf ca-certificates libttspico-utils llvm

	## Create a sw folder
	# Note: most of the configuration are independent from the location, but some could fail
	cd ~
	mkdir sw
	cd sw


	# git clone --recursive https://github.com/rhasspy/rhasspy
	git clone --recursive --branch $rh_tag_branch  https://github.com/rhasspy/rhasspy
	cd rhasspy/

	## Use one of the two options
	
	if [ "$virtual_env" = true ]; then
		echo "CHECK!!! A weird behviour in PIP is noticed, it installs all version of the same package..... Not sure what is going on"
		# rhasspy run in virtual env
		# probably it is necessary to change 
		./configure    --disable-pocketsphinx  --disable-julius  --disable-wavenet      --disable-precise  --disable-raven  --disable-porcupine  --disable-precise 
	else
		# Use the system environment
		./configure --enable-in-place --disable-virtualenv    --disable-pocketsphinx  --disable-julius  --disable-wavenet     --disable-precise  --disable-raven  --disable-porcupine  --disable-precise 
		# Note: possily some requirements has to be satisfied manually
	fi
	

	# for both
	make
	make install
```


#### Production

Change version and architecture accordingly

```batch
	cd ~
	mkdir -p  sw
	cd sw
	echo "Rhasspy is installed with bimnaries" 
	wget  https://github.com/rhasspy/rhasspy/releases/download/v2.5.9/rhasspy_2.5.9_armhf.deb
	sudo apt -y install ./rhasspy_2.5.9_armhf.deb
	
	# from command line run rhasspy and one of the available language profiles (eg en | de | it | .....)"
	rhasspy -p en
```

## Lisa 

This is a developlemnt only version but usable for production purposes


## Needed Packages for ODAS 


```batch
# fftw3
sudo apt -y install libfftw3-3  libfftw3-dev

# libconfig
sudo apt -y libconfig-dev

# json for C
sudo apt -y libjson-c-dev
```

## Installing rhasspy-lisa-odas-hermes

Install [rhasspy-lisa-odas-hermes](https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes) and  [lisa-odas](https://github.com/lawrence-iviani/lisa-odas)

```batch
cd ~
mkdir -p sw
cd sw

# LISA Hermes
git clone --recursive https://github.com/lawrence-iviani/rhasspy-lisa-odas-hermes.git

cd rhasspy-lisa-odas-hermes
./configure
make
cd lisa-odas/build
cmake ..
make
cd ../..
make install
cd ..

```

## Configuration

Most of the files are copied with:

```batch
python3 copy_util.py -t 
```
As mentioned in [https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/audio_hat.md](audio hat) check the configuration of the board is set right. 

**VERY IMPORTANT: Remeber to copy the ALSA asound.conf file in /etc/**

Finally, remeber to configure lisa with the proper ODAS file (depending on HW) in rhasspy_lisa_odas_hermes/config/lisa.cfg

* matrix_voice _odas_config = lisa-odas/config/lisa/lisa_matrix.cfg_
* respeaker_4mic _odas_config = lisa-odas/config/lisa/respeaker_4_mic_array.cfg_
* respeaker_4mic_linear _odas_config = lisa-odas/config/lisa/respeaker_4_mic_lineararray.cfg_
	


## Lisa ROS Bridge

In order to communicate with a ROS system a package named ROS bridge has been developed [lisa-mqtt-ros-bridge](https://github.com/lawrence-iviani/lisa-mqtt-ros-bridge). See [page ros extension](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/ros_extension.md)


## Lisa Led Manager

See: [rhasspy-lisa-led-manager](https://github.com/lawrence-iviani/rhasspy-lisa-led-manager) for options

```batch
cd ~
mkdir -p sw
cd sw

# LISA  LED
git clone https://github.com/lawrence-iviani/rhasspy-lisa-led-manager.git
cd rhasspy-lisa-led-manager
ln -s ../rhasspy-lisa-odas-hermes/lisa/ lisa
./configure
make
make install
```

