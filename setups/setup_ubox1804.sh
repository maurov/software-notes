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

#########################
# WORKFLOWS/DIRECTORIES #
#########################
# if migrating from existing machine/install
# -> manually copy 'WinLinShare' to DATA partition
# Links with VirtualBox shared folders
# symbolic link shared folders in $HOME, e.g.:
#cd $HOME
#ln -s /media/sf_WinLinShare/WORK* WORK*

#local software -> $MYLOCAL
cd; mkdir local
export MYLOCAL=$HOME/local/
#devel software -> $MYDEVEL
cd; mkdir devel
export MYDEVEL=$HOME/devel/

######################
### CUSTOM .bashrc ###
######################
echo "
file_to_load=$HOME/devel/software-notes/bash/mydotbashrcU1804.sh
if [ -f $file_to_load ]; then
    source $file_to_load
fi
" >> $HOME/.bashrc

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
sudo apt-get install dkms build-essential module-assistant autoconf shtool libtool swig
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#GUIDE: How to configure network in the guest OS in order to work with VPN
#https://superuser.com/questions/987150/virtualbox-guest-os-through-vpn/1035327

###############
# WEB BROWSER #
###############
sudo apt-get install firefox
#Add-ons installed:
#- Ghostery (https://addons.mozilla.org/en-US/firefox/addon/ghostery/)
#- Clean Links (https://addons.mozilla.org/en-US/firefox/addon/clean-links-webext/)
#- Forget me not (https://addons.mozilla.org/en-US/firefox/addon/forget_me_not) or Self destructing cookies (https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies-webex)

#################
# GIT & FRIENDS #
#################
sudo apt-get install git meld gftp rsync curl
#git config --global user.name "Mauro Rovezzi"
#git config --global user.email "mauro.rovezzi@gmail.com"
#git config --global credential.helper "cache --timeout=36000"

#########
# CONDA #
#########
cd $MYLOCAL
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -c -p $HOME/local/conda
source $MYLOCAL/conda/bin/activate
conda config --set always_yes yes
conda update -q conda
#conda environments are based on specific .yml files

################
# COLOR THEMES #
################
sudo apt-get install gnome-color-chooser

#########################################
### TEXT EDITORs/CONVERTERS/UTILITIES ###
#########################################
#ATOM
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
sudo apt-get install atom

####################################
### GRAPHICS: INKSCAPE & FRIENDS ###
####################################
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt-get install inkscape xclip graphviz
