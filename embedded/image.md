INSTALL

# Image

## OS
use Raspberry imager (or any image creation tool)
 https://www.raspberrypi.org/downloads/ 
 
 Raspbian 32 bit arm7fh (float hardware) (sic, debian has an availble 64 bit for arm8, unfortunately certain mic shield doesnt support the 64 bit architecture)
 16 GB SD
 
 ## Headless
 To enable SSH
 Add “SSH” File to the SD Card Root
 


### Raspbian 

**Suggested**

Go in [Raspberry Pi OS (Former Raspbian) page](https://www.raspberrypi.org/downloads/raspberry-pi-os/)
And download the latest Raspberry Pi OS (32-bit) Lite Minimal image based on Debian Buster
You can use the [Raspberry imager](https://www.raspberrypi.org/downloads/ 
) 
or any image creation tool like [Balena Etcher](https://www.balena.io/etcher/) or use the (new) imager tool
from [Raspberry](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)

 To enable SSH and headless configuration add “SSH” as the name of a empty file to the SD Card Root (no suffix!)

### Alternative (Debian)

**NOTE: on pi4 and pi3+ it would be possible to install the architecture arm64 ([ubuntu](https://wiki.ubuntu.com/ARM/RaspberryPi)) instead of the armhf (32-bit) but compatibility with the microphone HAT has to be verified (Matrix packages at 06/2020 doesn't seem available for 64-bit).**

[flash file can be found here](https://wiki.ubuntu.com/ARM/RaspberryPi)
or the [Raspberry Pi OS (Former Raspbian) page](https://www.raspberrypi.org/downloads/raspberry-pi-os/) 
And select Ubuntu 64 bit server for Pi 3/4