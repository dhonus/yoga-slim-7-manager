#!/bin/sh

echo "-------------------------"
echo "Manage Lenovo Yoga Slim 7"
echo "-------------------------"
echo "Select the desired operation"

current_mode=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode)
if [ $current_mode = "1" ]
then
  echo "  1. Toggle battery conservation mode (currently ENABLED)"
else
  echo "  1. Toggle battery conservation mode (currently DISABLED)"
fi
echo "  2. Change cooling  mode (current is "$(cat /sys/firmware/acpi/platform_profile)")"
echo "  6. Check available sleep states"
echo "  7. Fix touchpad (only perform once)"

#pretty recent addition to the kernel for this device (I think) so if this doesn't work update your kernel, can probably be swapped out for "echo 1 >> yaddayadda" instead of tee
battery_conserve () {
if [ $current_mode = "1" ]
then
  echo "The battery conservation mode has been DISABLED"
  sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode <<< 0
else
  echo "The battery conservation mode has been ENABLED"
  sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode <<< 1
fi
}

cooling_mode () {
  echo "-------------------------"
  echo "The following are the modes available"
  echo $(cat /sys/firmware/acpi/platform_profile_choices)
  echo "Choose which mode to apply. Currently using $(cat /sys/firmware/acpi/platform_profile)"
  echo "l - Low Power"
  echo "b - Balanced (Intelligent Cooling)"
  echo "p - Performance Mode"

  read MODE
  case $MODE in
    "l")
      echo low-power | sudo tee /sys/firmware/acpi/platform_profile
      ;;
    "b")
      echo balanced | sudo tee /sys/firmware/acpi/platform_profile
      ;;
    "p")
      echo performance | sudo tee /sys/firmware/acpi/platform_profile
      ;;
    *)
    echo "Not a valid argument"
    echo
    ;;
  esac
  echo "-------------------------"
  echo "The mode has been set to "$(cat /sys/firmware/acpi/platform_profile)

}


## arguments
case $1 in
  "--battery")
    battery_conserve
    exit
    ;;
  *)
    ;;
esac


read OPERATION
case $OPERATION in
  "1")
    battery_conserve
    ;;
  "2")
    cooling_mode
    ;;
  "6")
    echo "S3 should not be listed. https://wiki.archlinux.org/title/Lenovo_IdeaPad_7_14are05#Power_management"
    dmesg | grep 'S0\|S4\|S5'
    ;;
  "7")
    echo "This script will create a new file called "elan_touchpad_fix.conf" in the /etc/modprobe.d directory and will blacklist the conflicting device."
    echo "This should allow the touchpad to function normally. Reversible by deleting said file. Reboot afterwards."
    echo "[y,N]"
    read OK_TO_TOUCHPAD
    if [ $OK_TO_TOUCHPAD == "Y" ] || [ $OK_TO_TOUCHPAD == "y" ]
    then
      touch /etc/modprobe.d/elan_touchpad_fix.conf
      echo "blacklist elan_i2c" >> /etc/modprobe.d/elan_touchpad_fix.conf
      cat /etc/modprobe.d/elan_touchpad_fix.conf
      echo "all good"
    else
      echo "NOT running then"
    fi
    ;;
  *)
  echo "Not a valid argument"
  echo
  ;;
esac
