#!/bin/bash

# This script install the necessary HW + Audio HATS on the Pi

##############################
#### Configuration Option ####
##############################

# Activate the wifi hotspot
install_wifi=true

# Available  HATS
hardware="respeaker_4mic_linear" # "respeaker_4mic" "matrix_voice" 

##################################
#### End Configuration Option ####
##################################


cwd=$(pwd)

# Update system
sudo apt-get update 
sudo apt-get upgrade 

# Building tools
sudo apt-get -y install git cmake vim

# install other dependencies library 
sudo apt-get -y install  python3 python3-pip python3-setuptools python3-yaml  virtualenv 


if [ "$install_wifi" = true ]; then
	# In order to work as an access point, the Raspberry Pi needs to have the hostapd access point software package installed:

	sudo apt -y  install hostapd

	# Enable the wireless access point service and set it to start when your Raspberry Pi boots:

	sudo systemctl unmask hostapd
	sudo systemctl enable hostapd

	# In order to provide network management services (DNS, DHCP) to wireless clients, the Raspberry Pi needs to have the dnsmasq software package installed:

	sudo apt -y  install dnsmasq

	# Finally, install netfilter-persistent and its plugin iptables-persistent. This utilty helps by saving firewall rules and restoring them when the Raspberry Pi boots:

	sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent

	sudo cp ../configuration/all/etc/dhcpcd.conf /etc/dhcpcd.conf
	sudo cp ../configuration/all/etc/dnsmasq.conf /etc/dnsmasq.conf
	sudo cp ../configuration/all/etc/sysctl.d/routed-ap.conf /etc/sysctl.d/routed-ap.conf
	sudo cp ../configuration/all/etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf

fi


if [ "$hardware" = "matrix_voice" ]; then
	echo Hw: $hardware 
	curl https://apt.matrix.one/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.matrix.one/raspbian $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/matrixlabs.list

	# Update packages and install
	sudo apt-get update
	sudo apt-get upgrade

	# Installation
	sudo apt install matrixio-creator-init
	sudo apt install libmatrixio-creator-hal
	sudo apt install libmatrixio-creator-hal-dev
	
	echo "Reboot needed!!!"
	echo "after that execute manually"
	echo "$ sudo apt install matrixio-kernel-modules"
	
elif [ "$hardware" = "respeaker_4mic" ]; then
	echo Hw: $hardware 
	
	sudo pip3 install spidev gpiozero
	
	cd ~
	mkdir hw
	cd hw
	git clone https://github.com/respeaker/seeed-voicecard.git
	cd seeed-voicecard
	sudo ./install.sh
	echo "Reboot needed!!!"
	
	
	echo "Reboot needed!!!"
elif [ "$hardware" = "respeaker_4mic_linear" ]; then
	echo Hw: $hardware 
	
	cd ~
	mkdir hw
	cd hw
	git clone https://github.com/respeaker/seeed-voicecard.git
	cd seeed-voicecard
	sudo ./install.sh
	echo "Reboot needed!!!"
	
else
	echo Hw not recognized: $hardware 
fi

cd $cwd