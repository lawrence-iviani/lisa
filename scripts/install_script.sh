#!/bin/bash

install_wifi=true
hardware="respeaker_4mic_linear" # "respeaker_4mic" "matrix_voice"

# Building tools
sudo apt-get -y install git cmake vim

# install other dependencies library 
sudo apt-get -y install  python3 python3-pip python3-setuptools python3-yaml  virtualenv 


if [ "$install_wifi" = true ]; then
	# In order to work as an access point, the Raspberry Pi needs to have the hostapd access point software package installed:

	sudo apt install hostapd

	# Enable the wireless access point service and set it to start when your Raspberry Pi boots:

	sudo systemctl unmask hostapd
	sudo systemctl enable hostapd

	# In order to provide network management services (DNS, DHCP) to wireless clients, the Raspberry Pi needs to have the dnsmasq software package installed:

	sudo apt install dnsmasq

	# Finally, install netfilter-persistent and its plugin iptables-persistent. This utilty helps by saving firewall rules and restoring them when the Raspberry Pi boots:

	sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent

	sudo cp ..configuration/all/etc/dhcpcd.conf /etc/dhcpcd.conf
	sudo cp ../configuration/all/etc/dnsmasq.conf /etc/dnsmasq.conf
	sudo cp ../configuration/all/etc/sysctl.d/routed-ap.conf /etc/sysctl.d/routed-ap.conf
	sudo cp ../configuration/all/etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf
fi
