#!/bin/bash

#######################################################
# TODO: re-structure (organize!) the whole thing!
echo -n "Do you want to run this buggy script (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "OK, then modify it yourself!"
    exit
else
    echo "OK, then read it yourself!"
    exit
fi
#######################################################

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ubox1704 is XUbuntu 17.04 VirtuaBox guest in a Windows 10 host #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# /!\ the best Ubuntu flavor is XUbuntu /!\ #

#####################
### FRESH INSTALL ###
#####################

#Fresh install is a KIVY 2.0 virtual machine
#http://txzone.net/files/torrents/kivy-buildozer-vm-2.0.zip
#this machine has a great advantage that OpenGL works like a charm out of the box!!!

#after download import in virtualbox and adapt to:
#video memory 128 Mb
#enable 3D
#optical disk

