
All what matters the raspberry and the basic package installation:
* pre-requisities
* development package 
* wifi
* hotspot


# First Run, configure the Raspberry

**Find the Pi**
Well, there can be a number of possibility. 
I use a tool like [Advanced IP Scanner](https://www.advanced-ip-scanner.com/)

**Configure Pi**
SSH to the IP found in the step before, with your preferred tool.
Default credentials for a raspberry
*User:* pi
*password:* raspbian

**Configure the raspberry**

Run [raspi-config](https://www.raspberrypi.org/documentation/configuration/raspi-config.md) to configure some raspberry configuration

```batch
sudo raspi-config

```

* Resized SD
* wlan (if you consider to use wifi)
* Network (optional, if default DHCP is fine for you)

Reboot

## Bashrc

In .bashrc, I usually enable:

```batch
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
```

## Update the embedded OS

```batch
sudo apt-get update
sudo apt-get upgrade

# Tools

# Building tools
sudo apt-get install git cmake vim

# install other dependencies library 
sudo apt-get install  python3 python3-pip python3-setuptools python3-yaml  virtualenv  # TODO: need to check: libfftw3-3
**TODO: do we need  virtual env?**

# TODO: TO CHECK NO!!
# Development tools
Install only if you consider to develop an application
# sudo apt-get install python3-dev  python3-venv  sox alsa-utils build-essential portaudio19-dev  libfftw3-dev libconfig-dev  libjson-c-dev

```

# Setup a hotspot wireless
This is useful to control the board when the wired is busy in an [un-accessible network](https://www.raspberrypi.org/documentation/configuration/wireless/access-point-routed.md)

* The Wireless is set as static access point in the network 10.0.0.1/24 (Type C, 254 addresses)
* The DHCP is set to serve address from 10.0.0.2/20
* address is /lisa.wlan  or 10.0.0.1

```batch

# In order to work as an access point, the Raspberry Pi needs to have the hostapd access point software package installed:

sudo apt install hostapd

# Enable the wireless access point service and set it to start when your Raspberry Pi boots:

sudo systemctl unmask hostapd
sudo systemctl enable hostapd

# In order to provide network management services (DNS, DHCP) to wireless clients, the Raspberry Pi needs to have the dnsmasq software package installed:

sudo apt install dnsmasq

# Finally, install netfilter-persistent and its plugin iptables-persistent. This utilty helps by saving firewall rules and restoring them when the Raspberry Pi boots:

sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
```

**Config File**
**NOTE: these can be copied with scripts/copy_util.py**

Adjust based on your configuration the following file in [\etc\]([etc for 4-Mic Array](https://github.com/lawrence-iviani/lisa/tree/main/configuration/all/etc)):

* /etc/dhcpcd.conf
* /etc/dnsmasq.conf
* /etc/sysctl.d/routed-ap.conf
* /etc/hostapd/hostapd.conf

**WiFi Network**
In the file /etc/hostapd/hostapd.conf it is possible to set name and password of the access point.

* SSID: Lisa.wlan (this is also the address of the bot)
* password: L1sa@sc0lTa