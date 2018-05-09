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
# ubox1804 is XUbuntu 18.04 VirtuaBox guest in a Windows 10 host #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# /!\ the best Ubuntu flavor is XUbuntu /!\ #

#####################
### FRESH INSTALL ###
#####################

#Fresh install is xubuntu-18.04-desktop-amd64.iso virtual machine

######################
### PROXY SETTINGS ###
######################

# IN CASE YOU ARE INSTALLING BEHIND A PROXY (ESRF CASE HERE)
# http://askubuntu.com/questions/150210/how-do-i-set-systemwide-proxy-servers-in-xubuntu-lubuntu-or-ubuntu-studio
# set some env variables (add them in your .bashrc)
#export http_proxy=http://proxy.esrf.fr:3128/
#export https_proxy=http://proxy.esrf.fr:3128/
#export ftp_proxy=http://proxy.esrf.fr:3128/
#export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
#export HTTP_PROXY=http://proxy.esrf.fr:3128/
#export HTTPS_PROXY=http://proxy.esrf.fr:3128/
#export FTP_PROXY=http://proxy.esrf.fr:3128/
#export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"
# notify APT of proxy settings:
# - create a file called 95proxies in /etc/apt/apt.conf.d/
# - include the following:
#Acquire::http::proxy "http://proxy.esrf.fr:3128/";
#Acquire::ftp::proxy "ftp://proxy.esrf.fr:3128/";
#Acquire::https::proxy "https://proxy.esrf.fr:3128/";

# *NOTE*: use 'sudo -E <command>' to export the proxy variables also to root!!!

##################
### VIRTUALBOX ###
##################

# Settings
# ========
#- bidirectional clipboard/drag'n drop
#- 4096 MB RAM / 2 CPU
#- 128 MB video memory / 3D acceleration enabled
#- USB 3.0

# Guest Additions
# ===============
sudo apt-get install dkms build-essential module-assistant
sudo apt-get install autoconf shtool libtool swig
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#GUIDE: How to configure network in the guest OS in order to work with VPN
#https://superuser.com/questions/987150/virtualbox-guest-os-through-vpn/1035327

#############
# PACKAGING #
#############
sudo apt-get install aptitude

###############
# BUILD TOOLS #
###############
sudo aptitude install gfortran cython cython3 cython-doc

#################
# GIT & FRIENDS #
#################
sudo aptitude install git meld gftp subversion rsync curl
#git config --global user.name "Mauro Rovezzi"
#git config --global user.email "mauro.rovezzi@gmail.com"

#########################################
### TEXT EDITORs/CONVERTERS/UTILITIES ###
#########################################
#EMACS
sudo aptitude install emacs aspell-en aspell-fr aspell-it
#ln -s mydotemacs24U1604.el .emacs
#
sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt-get install emacs-snapshot
sudo update-alternatives --config emacs #select emacs-snapshot
#
#geany ide (useful for Spec macros editing)
sudo apt-get install geany
#
# PDF utilities
sudo apt-get install pdftk xpdf xpdf-utils
# scan utilities
sudo apt-get install gscan2pdf
