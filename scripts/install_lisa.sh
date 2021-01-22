#!/bin/bash

# This script install the necessary HW + Audio HATS on the Pi


##############################
#### Configuration Option ####
##############################

# Use RH Binaries, typically this should be false for development
rh_binaries=true

## RH Binaries version (only if  rh_binaries set to true)

rh_binaries_version="2.5.9"
arch="armhf"

## RH development  version (only if  rh_binaries set to false)
# Use the virutal environment... this needs more verification. when set to true, it doesnt work
virtual_env=false
# Decide which branch to download
rh_tag_branch="v2.5.7"


# Available  HATS
hardware="respeaker_4mic_linear" # "respeaker_4mic" "matrix_voice" 



##################################
#### End Configuration Option ####
##################################

cwd=$(pwd)


echo "######################"
echo "#### DEPENDENCIES ####"
echo "######################"

## Needed Packages etc.  Install some dependecies needed

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


echo "#################"
echo "#### RHASSPY ####"
echo "#################"

if [ "$rh_binaries" = true ]; then
	cd ~
	mkdir -p  sw
	cd sw
	echo "Rhasspy is installed with bimnaries" 
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
fi


echo "##############"
echo "#### LISA ####"
echo "##############"

## Needed Packages for ODAS 

# fftw3
sudo apt -y install libfftw3-3  libfftw3-dev

# libconfig
sudo apt -y libconfig-dev

# json for C
sudo apt -y libjson-c-dev

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

# LISA  LED
git clone https://github.com/lawrence-iviani/rhasspy-lisa-led-manager.git
cd rhasspy-lisa-led-manager
ln -s ../rhasspy-lisa-odas-hermes/lisa/ lisa
./configure
make
make install

cd $cwd

echo "########################"
echo "#### LISA CONFIGURE ####"
echo "########################"

# Return to scripts folder
cd $cwd
# configure all
python3 copy_util.py -t 

echo "Configuring specific HW"

if [ "$hardware" = "matrix_voice" ]; then
	echo Hw: $hardware 
	sudo cp ../configuration/Matrix_Voice/etc/asound.conf /etc/asound.conf
	echo "IMPORTANT!!!! in rhasspy_lisa_odas_hermes/config/lisa.cfg set:"
	echo "odas_config = lisa-odas/config/lisa/lisa_matrix.cfg"
	
elif [ "$hardware" = "respeaker_4mic" ]; then
	echo Hw: $hardware 
	sudo cp ../configuration/Respeaker_4mic_array/etc/asound.conf /etc/asound.conf
	echo "IMPORTANT!!!!  in rhasspy_lisa_odas_hermes/config/lisa.cfg set:"
	echo "odas_config = lisa-odas/config/lisa/respeaker_4_mic_array.cfg"

elif [ "$hardware" = "respeaker_4mic_linear" ]; then
	echo Hw: $hardware 
	sudo cp ../configuration/Respeaker_4mic_array/etc/asound.conf /etc/asound.conf
	echo "IMPORTANT!!!!  in rhasspy_lisa_odas_hermes/config/lisa.cfg set:"
	echo "odas_config = lisa-odas/config/lisa/respeaker_4_mic_lineararray.cfg"
	
else
	echo Hw not recognized: $hardware 
fi

cd $cwd