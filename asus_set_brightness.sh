#!/bin/sh
# taken from https://doc.ubuntu-fr.org/retro-eclairage
# to fix brightness control of Asuz Zenbook with Ubuntu 14.04
# to run this without sudo, follow these steps:
# sudo visudo -f /etc/sudoers.d/set_brightness
# 1000 aku = NOPASSWD:  /usr/bin/tee /sys/class/backlight/intel_backlight/brightn$
# note: '1000' is your user ID, 'aku' is the hostname 
if [ "$1" = "inc" ]; then
  cd /sys/class/backlight/intel_backlight/
  CURRENT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
  TO=`expr ${CURRENT} + 50`
  #echo "${CURRENT} + 50 = ${TO}"
  echo "${TO}" | sudo /usr/bin/tee /sys/class/backlight/intel_backlight/brightness
elif [ "$1" = "dec" ]; then
  #echo dec
  cd /sys/class/backlight/intel_backlight/
  CURRENT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
  TO=`expr ${CURRENT} - 50`
  #echo "${CURRENT} - 50 = ${TO}"
  echo "${TO}" | sudo /usr/bin/tee /sys/class/backlight/intel_backlight/brightness
elif [ "${1}" = "set" ]; then
  #echo "set ${2}"
  cd /sys/class/backlight/intel_backlight/
  CURRENT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
  #echo "${CURRENT} -> ${2}"
  echo "${2}" | sudo /usr/bin/tee /sys/class/backlight/intel_backlight/brightness
else
  echo 'Usage: $0 give inc, dec or set'
fi
