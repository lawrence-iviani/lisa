#!/bin/bash

# This script install the necessary HW + Audio HATS on the Pi


##############################
#### Configuration Option ####
##############################

# Use RH Binaries, typically this should be false for development
rh_binaries=true

# RH Binaries version (only if  rh_binaries set to true)
rh_binaries_version="2.5.9"
arch="armhf"

# Use the virutal environment, (only if  rh_binaries set to false)
virtual_env=true

# Available  HATS
hardware="respeaker_4mic_linear" # "respeaker_4mic" "matrix_voice" 



##################################
#### End Configuration Option ####
##################################

cwd=$(pwd)



##############################
#### Needed Packages etc. ####
##############################
# Install some dependecies needed

## Docker
curl -sSL https://get.docker.com | sh

# add your user the priviliegies
sudo usermod -a -G docker $USER

echo "Remember that you will have to log out and back in for this to take effect!"

## Tmuxinator
sudo apt -y install tmuxinator

cp  ../configuration/all/home/pi/.tmux.conf ~
# TODO: source  is not the correct way.... is needed at all?? Copy is not enough?
# source ~/.tmux.conf

##############################
#### Needed Packages etc. ####
##############################
if [ "$rh_binaries" = true ]; then
	cd ~
	mkdir sw
	cd sw
	echo "Rhasspy is installed with nimnaries" 
	wget  https://github.com/rhasspy/rhasspy/releases/download/v"$rh_binaries_version"/rhasspy_"$rh_binaries_version"_"$arch".deb
	sudo apt -y install ./rhasspy_"$rh_binaries_version"_"$arch".deb
	
	echo "from command line run rhasspy and one of the available language profiles (eg en | de | it | .....)"
	echo "$ rhasspy -p en"
	
else
	echo "Rhasspy is with repository" 
	
	# install dep
	sudo apt-get -y install portaudio19-dev libatlas-base-dev swig 
	
	## You should have something like this installed. Sometimes install automatically.
	# sudo apt-get -y install  libatlas-base-dev swig supervisor mosquitto sox alsa-utils libgfortran4 espeak flite perl curl patchelf ca-certificates libttspico-utils

	## Create a sw folder
	# Note: most of the configuration are independent from the location, but some could fail
	mkdir sw
	cd sw

	git clone --recursive https://github.com/rhasspy/rhasspy
	cd rhasspy/

	## Use one of the two options
	echo "Using  --disable-dependency-check, apprently there is some issue in 2.5.8.... THIS IS A BRUTAL FIX!!"
	
	if [ "$virtual_env" = true ]; then
		# rhasspy run in virtual env
		# probably it is necessary to change 
		./configure    --disable-pocketsphinx  --disable-julius  --disable-wavenet  --disable-larynx    --disable-precise  --disable-raven  --disable-porcupine  --disable-precise  --disable-dependency-check
	else
		# Use the system environment
		./configure --enable-in-place --disable-virtualenv    --disable-pocketsphinx  --disable-julius  --disable-wavenet  --disable-larynx    --disable-precise  --disable-raven  --disable-porcupine  --disable-precise  --disable-dependency-check
		# Note: possily some requirements has to be satisfied manually
	fi
	

	# for both
	make
	make install
	
	
fi


if [ "$hardware" = "matrix_voice" ]; then
	echo Hw: $hardware 

	
elif [ "$hardware" = "respeaker_4mic" ]; then
	echo Hw: $hardware 
	


elif [ "$hardware" = "respeaker_4mic_linear" ]; then
	echo Hw: $hardware 
	

	
else
	echo Hw not recognized: $hardware 
fi

cd $cwd