#!/bin/bash

# +++++++++++++++
# Annarella setup
# +++++++++++++++

# Annarella is a Dell Inspiron 1501 laptop
# The starting point is a fresh Xubuntu 12.04.4 installation

## Links
sudo mkdir /media/sf_WinLinShare
sudo chown mauro /media/sf_WinLinShare/
ln -s /home/mauro/biblio /media/sf_WinLinShare/biblio
ln -s /home/mauro/utils /media/sf_WinLinShare/utils
ln -s /home/mauro/WORK12 /media/sf_WinLinShare/WORK12
ln -s /home/mauro/WORK11 /media/sf_WinLinShare/WORK11

## System Packages
## ===============

### REMOVE UNWANTED SOFTWARE

### Revision control
sudo apt-get install git meld

### Reference manager (Mendeley)
wget http://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
sudo dpkg -i mendeleydesktop_1.11-stable_amd64.deb
sudo apt-get install libqtwebkit4 libqtsvg4-perl
mendeleydesktop
# configure your account, then enable your local version by the following
cd
mkdir .local/share/data
mkdir .local/share/data/Mendeley\ Ltd.
# assuming your Mendeley database is MendeleyDB
ln -s MendeleyDB .local/share/data/Mendeley\ Ltd./Mendeley\ Desktop
# assuming your Mendely configuration file is utils/Mendeley\ Desktop.conf
mkdir .config/Mendeley\ Ltd.
ln -s utils/Mendeley\ Desktop.conf .config/Mendeley\ Ltd./Mendeley\ Desktop.conf

### 3D and OpenGL
sudo apt-get install mesa-utils

### Utils & generic
sudo echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> /etc/apt/sources.list
sudo add-apt-repository ppa:libreoffice/ppa
sudo aptitude install openssh-server emacs emacs-goodies-el fonts-inconsolata inkscape libreoffice git virtualbox-4.2 offlineimap subversion dvipng xclip gftp aspell-en aspell-fr aspell-it dropbox-nautilus

### Hardware for Inspiron
sudo aptitude remove bcmwl-kernel-source
sudo aptitude install b43-fwcutter firmware-b43-installer

### Python & related
sudo aptitude install ipython ipython-notebook python-mode python-matplotlib python-scipy python-sphinx python-guiqwt python-sqlalchemy python-pandas python-openbabel

### Latex (+dependencies... huge distribution!) 
#### the following backport is for TexLive2012 on Ubuntu 12.04
sudo apt-add-repository ppa:texlive-backports/ppa
sudo aptitude install texlive latex-beamer biblatex texlive-latex-extra texlive-bibtex-extra texlive-lang-french texlive-lang-italian texlive-fonts-extra texlive-science texlive-publishers

### Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo aptitude update
sudo aptitude install google-chrome-stable

### Xraylib
curl http://lvserver.ugent.be/apt/xmi.packages.key | sudo apt-key add -
# add the following two lines /etc/apt/sources.list file (as root, without comment!):
# deb [arch=amd64] http://lvserver.ugent.be/apt/ubuntu precise stable
# deb-src http://lvserver.ugent.be/apt/ubuntu precise stable
sudo apt-get update
sudo apt-get install xraylib libxrl3-dev libxrlf03-3


### ASE and friends
# Instructions here: https://wiki.fysik.dtu.dk/ase/download.html#installation-with-package-manager-on-linux
sudo bash -c 'echo "deb http://download.opensuse.org/repositories/home:/dtufys/xUbuntu_12.04 /" > /etc/apt/sources.list.d/home_dtufys.sources.list'
wget http://download.opensuse.org/repositories/home:/dtufys/xUbuntu_12.04/Release.key && sudo apt-key add Release.key && rm Release.key
sudo apt-get update
sudo apt-get install python-ase gpaw gpaw-setups pycifrw pymatgen


## Local Packages (stored in ~/local)
## ==================================

### Emacs-related
ln -s /media/sf_WinLinShare/utils/mydotemacs .emacs
mkdir ~/local/emacs
cd ~/local/emacs

#### Emacs24
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get update
sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
##### .emacs -> mydotemacs24

#### Org-mode
#### ~/local/emacs/org-mode (Git repository)
git clone git://orgmode.org/org-mode.git

#### Naquadah-theme
#### ~/local/emacs/naquadah-theme (Git repository)
git clone http://git.naquadah.org/git/naquadah-theme.git

#### Mu
#### ~/local/emacs/mu (Git repository)
#### http://www.djcbsoftware.nl/code/mu/mu4e/Installation.html#Installation
cd ~/local/emacs
git clone git://github.com/djcb/mu.git
sudo aptitude install libgmime-2.6-dev libxapian-dev
#I suppose emacs23 already installed, otherwise install it
sudo aptitude install autoconf autotools-dev libtool texinfo

### CrackRAR
cd ~/local/crackrar-0.2
sudo aptitude install libxml2-dev
make
sudo make install

### PyMca
cd ~/local/
sudo aptitude install python-qt4 python-qt4-dev libqwt5-qt4 libqwt-dev python-qwt5-qt4
svn checkout http://svn.code.sf.net/p/pymca/code/ pymca-code
cd pymca-code
sudo SPECFILE_USE_GNU_SOURCE=1 python setup.py install

## BASH VARIABLES
## ==============
export PYTHONPATH=$HOME/utils:$PYTHONPATH

### Larch 
#Instructions: http://xraypy.github.com/xraylarch/downloads/index.html#source-installation
#### Deps:
sudo aptitude install python-wxgtk2.8 python-wxtools python-setuptools python-docutils python-h5py python-sqlalchemy
sudo easy_install wxmplot
cd ~/local
git clone http://github.com/xraypy/xraylarch.git
cd xraylarch
python setup.py build
sudo python setup.py install
#### Link larch plugins directory
cd ~/.larch/
rm -rf plugins
ln -s /home/mauro/utils/pymaus/larch_plugins plugins

### FDMNES
# Simply local copy of /sware/exp/fdmnes on NICE/ESRF
cd ~/local
rsync -avz --delete rovezzi@rnice6-0102:/sware/exp/fdmnes
sudo ln -s $HOME/local/fdmnes/bin/debian6/fdmnes /usr/local/bin/fdmnes

### FEFF9
# Simply local copy of /sware/exp/feff on NICE/ESRF
cd ~/local
rsync -avz --delete rovezzi@rnice6-0102:/sware/exp/feff
# Edit $HOME/local/feff9.6/bin/feff9 with the correct PATH_TO_FEFF9
sudo ln -s $HOME/local/feff9.6/bin/feff9 /usr/local/bin/feff9
