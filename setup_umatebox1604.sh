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

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# umatebox1606 setup                                                  #
# umatebox1604 is Ubuntu Mate 16.04 VirtuaBox guest in a Windows host #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

#####################
### FRESH INSTALL ###
#####################

# BASH VARIABLES
# ==============
# see: mydotbashrcUM1604

# SSH WITHOUT PASSWORD
# ====================
ssh-keygen -t rsa
#(do not enter passphrase)
ssh-copy-id -i <file.pub generated before> user@host
## or if your server uses custom port no:
ssh-copy-id -i <file.pub generated before> -p 1234 user@host
#keep alive ssh connections from client side:
#put the following in ~/.ssh/config (send null package every 100 sec)
#ServerAliveInterval 100

# PROXY SETTINGS: IN CASE YOU ARE INSTALLING BEHIND A PROXY (ESRF CASE HERE)
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

# =======================
# System & Local Packages
# =======================

##################
### VIRTUALBOX ###
##################

# To install Guest Additions on a fresh linux virtual machine
sudo apt-get install dkms build-essential module-assistant autoconf shtool libtool
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#############
# Workflows #
#############
# if migrating from existing machine/install
# -> manually copy 'WinLinShare' to DATA partition
# Links with VirtualBox shared folders
# sudo mkdir /media/sf_WinLinShare
sudo chown mauro /media/sf_WinLinShare/
# symbolic link everything in $HOME
#ln -s /home/mauro/biblio /media/sf_WinLinShare/biblio
#ln -s /home/mauro/utils /media/sf_WinLinShare/utils
#ln -s /home/mauro/utils /media/sf_WinLinShare/ownClowd/WORKtmp WORKtmp
#ln -s /home/mauro/WORK* /media/sf_WinLinShare/WORK*

#############
# PACKAGING #
#############
sudo apt-get install aptitude synaptic gdebi-core

###############
# BUILD TOOLS #
###############
sudo aptitude install gfortran

#################
# GIT & FRIENDS #
#################
sudo aptitude install git meld gftp subversion rsync curl

########################
# EMAIL -> THUNDERBIRD #
########################
sudo aptitude install thunderbird thunderbird-globalmenu
# to keep local config, link .thunderbird -> /media/sf_WinLinShare/dotThunderbird
# mail dir is '/media/sf_WinLinShare/MailThunderbird

##########################################
### REFERENCE MANAGER: MENDELEY/ZOTERO ###
##########################################
# Mendeley
sudo apt-get install libqtwebkit4 libqtsvg4-perl
wget http://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
sudo dpkg -i mendeleydesktop-latest
mendeleydesktop
# Mendeley does not like to work with a link, have to make a copy!
# configure your account, then enable your local version by the following
cd; cd .local/share/data/Mendeley\ Ltd.
rm -rf Mendeley\ Desktop
# assuming your database directory is 'MendeleyDB'
cp -r /path/to/MendeleyDB Mendeley\ Desktop
# assuming your configuration file is 'Mendeley\ Desktop.conf'
cd; cd .config/Mendeley\ Ltd.
cp /path/to/Mendeley\ Desktop.conf .
# start Mendeley and everything should be in place!

#########################################
### TEXT EDITORs/CONVERTERS/UTILITIES ###
#########################################
#EMACS
sudo aptitude install emacs aspell-en aspell-fr aspell-it
#Spacemacs variant
cd; rm -rf .emacs.d; rm .emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
#start in http mode, otherwise will not correctly install
emacs --insecure

####################################
### GRAPHICS: INKSCAPE & FRIENDS ###
####################################
sudo aptitude install inkscape xclip graphviz

###############
### TEXLIVE ###
###############
#a sub-selection from texlive-full package
sudo aptitude install texlive-lang-french texlive-science-doc texlive-generic-recommended texlive-latex-extra texlive-formats-extra latexdiff texlive-binaries texlive-base texlive-latex-recommended lcdf-typetools texlive-fonts-recommended-doc texlive-pstricks-doc texlive-font-utils texlive-humanities-doc context texlive-htmlxml texlive-metapost-doc texlive-metapost texlive-pstricks purifyeps dvidvi texlive-generic-extra prosper texlive-publishers texlive-science fragmaster texlive-lang-italian texlive-fonts-recommended texlive-lang-english texlive-latex-extra-doc prerex texlive-humanities texinfo texlive-xetex texlive-fonts-extra-doc texlive-math-extra texlive-luatex feynmf texlive-fonts-extra texlive-plain-extra texlive-publishers-doc chktex texlive-extra-utils lmodern tex4ht texlive-pictures-doc psutils tex-gyre texlive-games texlive-latex-base dvipng texlive-omega latexmk lacheck tipa texlive-music texlive-latex-recommended-doc texlive-latex-base-doc texlive-pictures texlive-bibtex-extra t1utils xindy
