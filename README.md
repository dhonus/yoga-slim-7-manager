# yoga-slim-7-manager

This tool serves to toggle a selection of useful features which are hard to get to on Linux. Tested for Arch Linux and should work for its derivatives. Only works for Yoga Slim 7 14ARE05, do not attempt to use this tool without change on a different device. I will very probably add more features to this, this is an early version and may have a few bugs.

## Features

* Toggle battery conservation mode (charge limit to 60%)
* Change cooling mode (Low Power, Intelligent Cooling and Performance Mode)
* Check available sleep states
* Touchpad fix for Arch

At this time this laptop works very well in Arch, only requiring a blacklist of "elan_i2c" to fix the touchpad inconsistency.

refer to [this arch wiki link](https://wiki.archlinux.org/title/Lenovo_IdeaPad_7_14are05) for more details

## Prerequisites

First install acpi_call (or acpi_call-lts for LTS kernel, acpi_call-dkms for other kernels) for the ability to switch cooling modes... also load the kernel module: 

``sudo pacman -S acpi_call``

``sudo modprobe acpi_call``

don't forget to reboot!

### Usage

Run with superuser privileges.

1. clone or curl this script
2. ``chmod +x yoga.sh``
3. ``sudo ./yoga.sh``


``sudo ./yoga.sh``

quick battery conserve toggle:

``./yoga.sh --battery``

![alt text](screenshot.jpg)
