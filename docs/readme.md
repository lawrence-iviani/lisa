# Full installation guide

* [Full Installation](https://github.com/lawrence-iviani/lisa/blob/main/docs/install.md)

# Quick Start

** EXPERIMENTAL **

Setup your system with Pi configuration as described in:
* [Install the image](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/image.md)
* Or download an image from here TODO: add image
* Typically you want Resize the SD, activate wifi (this if you need to access as hotspot Lisa), set network if default is not an option [see configure pi](https://github.com/lawrence-iviani/lisa/blob/main/docs/embedded/pi.md#configure-the-raspberry)

Set up git and get the lisa main repository

```batch
sudo apt-get -y install git
cd ~
git clone https://github.com/lawrence-iviani/lisa.git
cd lisa/scripts

# Change the comnfiguration variable at the top of the script (TODO: input variables should be used!!!)
./install_pi.sh

# Typically you have to reboot and in some case still do some manual step (e.g. Matrix Boards)
```

Reference [Install the LISA system and dependecies](https://github.com/lawrence-iviani/lisa/blob/main/docs/lisa/old_nodes_installation.md)
