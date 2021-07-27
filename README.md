# yoga-slim-7-manager

This tool serves to toggle a selection of useful features which are hard to get to on Linux. Tested for Arch Linux and should work for its derivatives.

At this time this laptop works very well in Arch, only requiring a blacklist of "elan_i2c" to fix the touchpad inconsistency.

* Toggle battery conservation mode (charge limit to 60%)
* Check available sleep states
* Touchpad fix for Arch

I am looking into providing a system performance mode switcher (intelligent cooling, battery saving and extreme performance), which has apparently been added in the latest kernel.

refer to [this arch wiki link](https://wiki.archlinux.org/title/Lenovo_IdeaPad_7_14are05) for more details

### Usage

1. clone or curl this script
2. ``chmod +x yoga.sh``
3. ``./yoga.sh``

for more advanced features you may need to run the script as root.

``sudo ./yoga.sh``


