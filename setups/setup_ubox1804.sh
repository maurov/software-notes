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

##################
### VIRTUALBOX ###
##################

#Settings
#========
#- bidirectional clipboard/drag'n drop
#- 4096 MB RAM / 2 CPU
#- 128 MB video memory / 3D acceleration enabled
#- USB 3.0

#Guest Additions
#===============
sudo apt install dkms build-essential module-assistant autoconf shtool libtool swig
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#GUIDE: How to configure network in the guest OS in order to work with VPN
#https://superuser.com/questions/987150/virtualbox-guest-os-through-vpn/1035327

#Bug in missing shared library
#=============================
#https://www.virtualbox.org/ticket/18324
sudo apt install patchelf
sudo patchelf --add-needed libcrypt.so.1 /opt/VBoxGuestAdditions-6.0.4/lib/VBoxOGLcrutil.so

#Bug with Qt
#===========
#https://askubuntu.com/questions/308128/failed-to-load-platform-plugin-xcb-while-launching-qt5-app-on-linux-without
sudo apt install libqt5x11extras5

###############
# WEB BROWSER #
###############
sudo apt install firefox
#Add-ons installed:
#- Ghostery (https://addons.mozilla.org/en-US/firefox/addon/ghostery/)
#- Clean Links (https://addons.mozilla.org/en-US/firefox/addon/clean-links-webext/)
#- Forget me not (https://addons.mozilla.org/en-US/firefox/addon/forget_me_not) or Self destructing cookies (https://addons.mozilla.org/en-US/firefox/addon/self-destructing-cookies-webex)

#################
# GIT & FRIENDS #
#################
sudo apt install git meld gftp rsync curl
#git config --global user.name "Mauro Rovezzi"
#git config --global user.email "mauro.rovezzi@gmail.com"
#git config --global credential.helper "cache --timeout=36000"

#########################################
### TEXT EDITORs/CONVERTERS/UTILITIES ###
#########################################
#ATOM
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt update
sudo apt install atom
#EMACS
sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt update
sudo apt install emacs-snapshot aspell-en aspell-fr aspell-it
sudo update-alternatives --config emacs #select emacs-snapshot
#ln -s mydotemacsU1804.el .emacs

#PANDOC
sudo apt install pandoc pandoc-citeproc pandoc-data python-pandocfilters python3-pandocfilters

#########################
### TEXLIVE & RELATED ###
#########################
sudo add-apt-repository ppa:jonathonf/texlive
sudo apt update
#A personal sub-selection from texlive-full package
sudo apt install texlive-lang-french texlive-science texlive-science-doc texlive-generic-recommended texlive-latex-extra texlive-formats-extra latexdiff texlive-binaries texlive-base texlive-latex-recommended lcdf-typetools texlive-fonts-recommended-doc texlive-pstricks-doc texlive-font-utils texlive-humanities-doc context texlive-htmlxml texlive-metapost-doc texlive-metapost texlive-pstricks purifyeps dvidvi texlive-generic-extra prosper texlive-publishers  fragmaster texlive-lang-italian texlive-fonts-recommended texlive-lang-english texlive-latex-extra-doc prerex texlive-humanities texinfo texlive-xetex texlive-fonts-extra-doc texlive-luatex feynmf texlive-fonts-extra texlive-plain-extra texlive-publishers-doc chktex texlive-extra-utils lmodern tex4ht texlive-pictures-doc psutils tex-gyre texlive-games texlive-latex-base dvipng texlive-omega latexmk lacheck tipa texlive-music texlive-latex-recommended-doc texlive-latex-base-doc texlive-pictures texlive-bibtex-extra t1utils xindy
#install non free fonts as user
wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
sudo texlua ./install-getnonfreefonts -a
getnonfreefonts -a --user


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

################
### SSH KEYS ###
################
#NOTE: -C is only a comment to identify multiple keys
ssh-keygen -o -t rsa -b 4096 -C "user@machine_virtual"
#(do not enter passphrase)
#Your identification has been saved in $HOME/.ssh/id_rsa.
#Your public key has been saved in $HOME/.ssh/id_rsa.pub.

#1) copy public key to a server
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub user@host
## or if your server uses custom port number:
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub -p 1234 user@host

#keep alive ssh connections from client side:
#put the following in ~/.ssh/config (send null package every 100 sec)
#ServerAliveInterval 100

#2) copy to gitlab
sudo apt install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
#paste you key in the web interface
#test if everything works
ssh -T git@gitlab.com
#should get a welcome message

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
sudo apt install gnome-color-chooser

####################################
### GRAPHICS: INKSCAPE & FRIENDS ###
####################################
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape xclip graphviz
