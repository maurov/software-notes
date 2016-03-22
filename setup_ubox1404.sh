#!/bin/bash

# TODO: re-structure (organize!) the whole thing!
echo -n "Do you want to run this buggy script (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
    echo "OK, then modify it!"
    exit
else
    echo "OK, read it!"
    exit
fi

# ++++++++++++++
# Ubox1404 setup
# ++++++++++++++

# Ubox1404 is a fresh Xubuntu 14.04.2 installation
# Ubox1404 is also a Windows machine running virtual OSs (virtualbox):
# - Xubuntu 14.04

#####################
### FRESH INSTALL ###
#####################

# BASH VARIABLES
# ==============
# see: mydotbashrcU1404

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

# VIRTUALBOX
# To install Guest Additions on a fresh linux virtual machine
sudo apt-get install dkms build-essential module-assistant autoconf shtool libtool
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#Virtualbox for Linux Host
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-5.0

# dual-monitor under XFCE <4.12
# first enable dual monitor in virtualbox
sudo aptitude install x11-server-utils
#identify your monitor names via 'xrandr -q' (here VBOX0 and VBOX1)
#xrandr --auto --output VBOX0 --mode 1680x956 --right-of VBOX1
xrandr --auto --output VGA-0 --mode 1680x956 --right-of VGA-1
# then put this command in the starting applications

# Workflows
# Links with VirtualBox shared folders
# sudo mkdir /media/sf_WinLinShare
sudo chown mauro /media/sf_WinLinShare/
# symbolic link everything in $HOME
#ln -s /home/mauro/biblio /media/sf_WinLinShare/biblio
#ln -s /home/mauro/utils /media/sf_WinLinShare/utils
#ln -s /home/mauro/WORK* /media/sf_WinLinShare/WORK*

# local directory
cd; mkdir local

# Package manager: aptitude
sudo apt-get install aptitude synaptic gdebi-core

# Revision control (Git & friends)
sudo apt-get install git meld gftp subversion rsync curl

# Build tools
sudo aptitude install gfortran

# Disk utilities
sudo aptitude install gnome-disk-utility testdisk

# Power utilities
sudo aptitude install powerstat

# Editor (Emacs & friends)
sudo aptitude install emacs emacs-goodies-el emacs-goodies-extra-el emacs-intl-fonts fonts-inconsolata aspell-en aspell-fr aspell-it gedit
## conf
cd; ln -s /media/sf_WinLinShare/utils/mydotemacs24U1404 .emacs
## local
cd; mkdir ~/local/emacs
cd ~/local/emacs

# Web
# default flash plugin does not always work properly... Adobe one is
# better
sudo aptitude install flashplugin-installer

# Email
# Thunderbird is fine
sudo aptitude install thunderbird thunderbird-globalmenu
# to keep local config, link .thunderbird -> utils/dotThunderbird

# Office (Libreoffice & friends)
sudo apt-get remove abiword gnumeric --purge
sudo apt-add-repository ppa:libreoffice/ppa
sudo aptitude install libreoffice libreoffice-pdfimport libreoffice-l10n-en-gb myspell-en-gb hyphen-en-gb mythes-en-us libreoffice-help-en-gb libreoffice-l10n-fr myspell-fr hyphen-fr mythes-fr libreoffice-l10n-it myspell-it hyphen-it mythes-it libxrender1 libgl1 openclipart-libreoffice pstoedit imagemagick libpaper-utils

# Diff-pdf
# https://github.com/vslavik/diff-pdf
cd $MYLOCAL
git clone https://github.com/vslavik/diff-pdf
cd diff-pdf
sudo apt-get install make automake g++
sudo apt-get install libpoppler-glib-dev poppler-utils wxgtk2.8-dev
./bootstrap
./configure
make
sudo make install
#=> diff-pdf

# Graphics (Inkscape & friends)
sudo add-apt-repository ppa:inkscape.dev/stable
sudo aptitude install inkscape xclip graphviz

# Multimedia
sudo aptitude install vlc avidemux openshot xubuntu-restricted-extras libavcodec-extra handbrake
# to play encrypted DVDs
sudo aptitude install libdvdread4
#sudo /usr/share/doc/libdvdread4/install-css.sh
sudo aptitude install mencoder
# Ubuntu 14.04 multimedia PPA
sudo sudo add-apt-repository ppa:mc3man/trusty-media
sudo aptitude update
sudo aptitude upgrade
sudo aptitude install ffmpeg

### Xraylib // from binary package (WORKING!!!)
###            see within virtual environment for source (below)
curl http://lvserver.ugent.be/apt/xmi.packages.key | sudo apt-key add -
sudo nano /etc/apt/sources.list.d/xraylib.list
###XRAYLIB
##deb [arch=amd64] http://lvserver.ugent.be/apt/ubuntu trusty stable
##deb-src http://lvserver.ugent.be/apt/ubuntu trusty stable
sudo apt-get update
sudo apt-get install libxrl7 xraylib libxrl7-dev libxrlf03-7 libxrl-perl python-libxrl7

# Mendeley Reference manager (TODO: move to Zotero!)
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

# VESTA
cd; cd local
wget http://www.geocities.jp/kmo_mma/crystal/download/VESTA-x86_64.tar.bz2
tar xjvf VESTA-x86_64.tar.bz2
ln -s VESTA-x86_64/VESTA $HOME/.local/bin/vesta

####################################################
### LaTeX / TeX Live distribution (current 2015) ###
####################################################

# https://github.com/scottkosty/install-tl-ubuntu
cd; cd local; git clone https://github.com/scottkosty/install-tl-ubuntu.git
cd install-tl-ubuntu; sudo -E ./install-tl-ubuntu -m
# restart computer or source /etc/environment
# /opt/texbin (the install dir) is added to PATH
# give you the rights on texlive
sudo chown -R mauro.users /usr/local/texlive
# install non free fonts
wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
texlua ./install-getnonfreefonts -a
getnonfreefonts -a

###############
### DOCONCE ###
###############
# https://github.com/hplgit/doconce
# NOTE: doconce is python2.7 based
cd; cd local; git clone https://github.com/hplgit/doconce.git
cd doconce
python setup.py install --user

# Ifeffit & Friends
# better to use old version until Demeter will fully work with Larch
sudo aptitude install horae ifeffit

#QT
sudo aptitude install qt4-dev-tools qt4-designer libqt4-dev libqt4-opengl

# PYTHON2
sudo aptitude install python-dev python-pip python-setuptools python-docutils python-numpy python-matplotlib python-mpltoolkits.basemap python-scipy ipython python-qt4 python-qt4-dev python-h5py python-pandas python-sqlalchemy cython

# User upgrades for python2 modules via pip
# Matplotlib
sudo apt-get install libfreetype6-dev libxft-dev libpng-dev
# this is to solve a known bug in building matplolib from pip
pip install -U matplotlib --user
pip install palettable --user

# LARCH (python2, for py34 see below virtual env)
# http://xraypy.github.io/xraylarch
# (assuming previous Python packages installed)
# Wx:
sudo aptitude install python-wxgtk2.8 python-wxtools
pip install --user -U wxmplot wxutils termcolor
cd ~/local
git clone http://github.com/xraypy/xraylarch.git
cd xraylarch
python setup.py build
python setup.py install --user

#####################################
### PYTHON3 : VIRTUAL ENVIRONMENT ###
#####################################

# Python3 system-wide required packages
sudo aptitude install python3-dev python3-pyqt4 cython3

# NOTE: qt5 may interfere with qt4
sudo aptitude install pyqt5-dev pyqt5-dev-tools python3-pyqt5 python3-pyqt5.qtsvg

# REMOVE python3-related packages that will be installed within a virtual environment
sudo apt-get remove python3-pip python3-setuptools python3-docutils python3-numpy python3-matplotlib python3-scipy ipython3 python3-h5py python3-pandas python3-sqlalchemy

#------------------------------------------------------------------#
### Python 3.4 VIRTUAL ENV
cd $MYLOCAL
python3.4 -m venv py34 --clear --without-pip --system-site-packages
source py34/bin/activate
cd py34; wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install --upgrade pip setuptools distribute

# Numpy
sudo apt-get -y install python3-dev g++ libblas-dev liblapack-dev gfortran
pip install -U numpy 

# Scipy
pip install -U scipy

# Bottlechest
# NOTE: better to install from sources to avoid problems (with numpy version?) 
# pip install --upgrade bottlechest>=0.7.0
git clone https://github.com/biolab/bottlechest
cd bottlechest
python setup.py install
cd ..

# Matplotlib
sudo apt-get install libfreetype6-dev libxft-dev libpng-dev
# this is to solve a known bug in building matplolib from pip
pip install -U matplotlib

# IPython & friends
pip install -U pygments pyzmq ipython qtconsole jupyter

#pyqtconsole (only for evaluation... better to use qtconsole!)
#https://github.com/marcus-oscarsson/pyqtconsole
#pip install -U gevent pyqtconsole

# Utils
pip install -U palettable termcolor seaborn

# H5py
sudo apt-get install libhdf5-dev
pip install -U h5py

# Orange
pip install -U chardet nose Jinja2 Sphinx recommonmark numpydoc beautifulsoup4 xlrd
pip install -U orange-canvas-core orange-widget-core

### PyMca5
# USER-LOCAL INSTALL: recommended (in .local/lib/pythonX.Y/site-packages/)
cd ~/local/
# fisx (not required, can be done at pymca setup!)
#git clone https://github.com/vasole/fisx.git 
#cd fisx
#python3 setup.py install --user
#pymca
git clone https://github.com/vasole/pymca.git
cd pymca
#SPECFILE_USE_GNU_SOURCE=1 python setup.py install --user --fisx
# USER INSTALL: alternative (within a virtual environment)
# (in_your_virt_env)
SPECFILE_USE_GNU_SOURCE=1 python setup.py install --fisx
# SYSTEM-WIDE INSTALL: not recommended
#sudo SPECFILE_USE_GNU_SOURCE=1 python setup.py install
# make CLEAN:
#(sudo) rm -rf /usr/local/lib/python2.7/dist-packages/PyMca*
#(sudo) rm -rf ~/local/pymca/build/
#
# documentation
python setup.py build_doc

### SHADOW3 (with python 3.4)
cd $MYLOCAL
git clone https://github.com/srio/shadow3.git
cd shadow3
cd src
make
make all
make install
cd ..
python setup.py build
python setup.py install 
# set global variables (not very elegant, but works!)
export SHADOW3_HOME=$MYLOCAL/shadow3
export LD_LIBRARY_PATH=$SHADOW3_HOME:$LD_LIBRARY_PATH

#not required anymore
#export SHADOW3_BUILD=$SHADOW3_HOME/build/lib.linux-x86_64-2.7
#export SHADOW3_BUILD=$SHADOW3_HOME/build/lib.linux-x86_64-3.4
#export PYTHONPATH=$SHADOW3_BUILD:$PYTHONPATH

# Xraylib (https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_virtual_environment.sh)
sudo aptitude install swig
curl -O https://github.com/tschoonj/xraylib/archive/xraylib-3.1.0.tar.gz
tar xvfz xraylib-3.1.0.tar.gz
cd xraylib-3.1.0
autoreconf -i
./configure --enable-python --enable-python-integration PYTHON=`which python`
make
export PYTHON_SITE_PACKAGES=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
cp python/xrayhelp.py $PYTHON_SITE_PACKAGES 
cp python/xraylib.py $PYTHON_SITE_PACKAGES 
cp python/.libs/xraylib_np.so  $PYTHON_SITE_PACKAGES
cp python/.libs/_xraylib.so  $PYTHON_SITE_PACKAGES
cp python/xraymessages.py  $PYTHON_SITE_PACKAGES 
cd ..

#SRxraylib
git clone https://github.com/lucarebuffi/srxraylib
cd srxraylib
python setup.py install
cd ..

# oasys and shadowOui (https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_virtual_environment.sh)
git clone https://github.com/lucarebuffi/oasys1
cd oasys1
python setup.py develop
cd ..
git clone https://github.com/lucarebuffi/shadowOui
cd shadowOui
python setup.py develop
cd ..

### XOP2.3
# NOTE: xop2.4 is the currently supported version, but a license
# request has to be completed befor downloading it. Here I still do
# the case for xop2.3
export MYLOCAL=~/local/
cd $MYLOCAL
wget http://ftp.esrf.eu/pub/scisoft/xop2.3/xop2.3_Linux_20140616.tar.gz
tar xzvf xop2.3_Linux_20140616.tar.gz
export XOP_HOME=$MYLOCAL/xop2.3

# to link SHADOW3 with XOP
cd $MYLOCAL/xop2.3/extensions
wget http://ftp.esrf.eu/pub/scisoft/xop2.3/shadowvui1.12_Linux_xop2.3.tar.gz
tar xzvf shadowvui1.12_Linux_xop2.3.tar.gz
cd shadowvui
rm -rf shadow3
ln -s $MYLOCAL/shadow3 shadow3

# TIPS:
# run shadow with 'xop shadowvui'
# put all previous environment variables in .bashrc
cd; ln -s $MYLOCAL/xop2.3/xop .local/bin/xop

### CRYSTAL
cd $MYLOCAL
git clone https://github.com/srio/CRYSTAL.git
cd CRYSTAL
make
export DIFFPAT_EXEC=$MYLOCAL/CRYSTAL/diff_pat

# LARCH
# build/install for python3
#NOTE: wxPython is not supported for python3 (plotting functionalities
#      will not be available in Larch, this is to use it as library)
python setup.py build
python setup.py install
# Link larch plugins directory
cd ~/.larch/
rm -rf plugins
ln -s your_larch_plugins_dir plugins

### !!!DEPRECATED!!! Xraylib // built from source [see install notes before]
# https://github.com/tschoonj/xraylib/wiki/Installation-instructions
cd $MYLOCAL
git clone clone https://github.com/tschoonj/xraylib.git
cd xraylib
# required: sudo aptitude install autoconf shtool libtool cython3 swig
#export PYTHON_VERSION=3.4
autoreconf -i
./configure --prefix=$HOME/.local --enable-python --enable-python-integration
PYTHON=/full/path/to/your/virtualenv/bin/python3.4
make
make check
make install

### !!!DEPRECATED!!! OASYS (inside py34 venv) [see install notes before]
#http://www.elettra.eu/lightsources/labs-and-services/hard-soft-x-ray-optical-engineering/oasys.html
cd $MYLOCAL
git clone https://github.com/biolab/orange3.git
cd orange3
# check deps (if not, UPGRADE NUMPY FIRST!)
#numpy >= 1.9.2, scipy >= 0.15.1, matplotlib >= 1.4.3
#python >>> import numpy >>> numpy.version.version
#python >>> import scipy >>> scipy.version.version
#python >>> import matplotlib >>> matplotlib.__version__
#
#xraylib
#PyMca5 (5.1.0)
#Shadow (it can now be installed via: pip install pykern, pip install shadow3)
pip install oasys
#python -m oasys.canvas
#go to the add-on form (directly from the welcome form) e install ShadowOui

#---workaround in case behind proxy and setting 'http_proxy' and
#---'https_proxy' environmental variables does not help
#The working procedure to install ShadowOui add-on in case of behind a
#proxy (once the GUI is correctly installed, check with python -m
#oasys.canvas):
#git clone ShadowOui repository somewhere
#(within a virtual environment or with superuser rights, with
#python3.4) python setup.py sdist develop


#------------------------------------------------------------------#
# to deactivate the 'py34' virtual environment
deactivate
#------------------------------------------------------------------#


#=====================================================================#
### WORK IN PROGRESS ###
#=====================================================================#

#------------------------------------------------------------------#

#=====================================================================#
### OLD ###
#=====================================================================#


### Hardware for Inspiron
sudo aptitude remove bcmwl-kernel-source
sudo aptitude install b43-fwcutter firmware-b43-installer
# Remove ATI fglrx driver
sudo apt-get remove fglrx fglrx-amdcccle --purge

### 3D and OpenGL
sudo apt-get install mesa-utils freeglut3 freeglut3-dev binutils-gold


# Dropbox better if downloaded directly
sudo apt-get remove nautilus-dropbox --purge
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb
sudo dpkg -i dropbox_1.6.0_amd64.deb
#$ dropbox start -i

### BLAS/ATLAS/LAPACK
sudo apt-get install -qq libblas-dev liblapack-dev
#
sudo aptitude install libopenblas-base libopenblas-dev libatlas3gf-base
# may not work with Numpy (try to fix with the following)
sudo update-alternatives --config libblas.so.3gf
# check it is setted to libopenblas
sudo update-alternatives --config liblapack.so.3gf
# check it is setted to atlas-base
export ATLAS=/usr/lib/atlas-base
export BLAS=/usr/lib/openblas-base
# then build/install numpy!
# python -c 'import numpy' # if not working, revert back liblapack.so.3gf to /usr/lib/lapack


# Python OpenGL
sudo apt-get install python-opengl libqt4-opengl libgle3
# Python Visual (NOT WORKING YET!!!)
sudo aptitude install python-visual libgtkglextmm-x11-1.2-dev

### Python 2 modules via PIP (NOTE: better from user)
#### ipython upgrade
sudo pip install ipython -U
#### matplotlib upgrade (NOTE: it will upgrade numpy!)
sudo easy_install -U distribute
sudo pip install matplotlib -U
### pandas upgrade
sudo pip install pandas -U
### brewer2mpl -> palettable (https://jiffyclub.github.io/palettable/)
pip install palettable --user

### Python 2.7 local virtual environment
easy_install --user -U virtualenv
cd; cd local
virtualenv --system-site-packages --distribute py2env
source py2env/bin/activate
easy_install -U distribute
### larch
pip install -U wxutils
pip install -U termcolor
pip install -U wxmplot
pip install -U sqlalchemy
cd xraylarch
##nano lib/site_configdata.py
## unix_installdir = '$HOME/.local/share/larch'
python setup.py build
python setup.py install


### Python 3.2 local virtual environment
cd; cd local
virtualenv -p python3 --system-site-packages --distribute py3env
source py3env/bin/activate
easy_install -U distribute
pip install --upgrade pip
#NOTE: ipython and sphinx last versions require python >=2.7 or >=3.3
pip install -U numpy==1.9.1
pip install -U scipy==0.15.0
pip install -U scikit-learn==0.15.2
pip install -U bottlechest==0.7.0
pip install -U nose==1.2.1 mock==1.0.1
pip install -U ipython==0.13.2
#newer versions work only with >=3.3 and 0.12.1 has a bug in the --gui threads
pip install -U matplotlib==1.4.2
# deps 'six python-dateutil pyparsing' should be installed by default
pip install -U pandas==0.15.2
sudo apt-get install libhdf5-serial-dev
pip install -U h5py==2.4.0
pip install -U sympy
# cd to pymca local distrib
# (in_your_virt_env) SPECFILE_USE_GNU_SOURCE=1 python setup.py build
# (in_your_virt_env) python setup.py install
#pymca: see local install
#shadow3: see local install
#shadow3: after make; make python; run as user and within virt_env 'python setup.py install'
#orange-shadow
#xraylib: TODO

### Python 3.4 (on Ubuntu 12.04)
sudo add-apt-repository ppa:fkrull/deadsnakes
sudo apt-get install python3.4 libpython3.4-dev
sudo pip install -U virtualenv
virtualenv-2.7 -p python3.4 py34
virtualenv -p python3.4 py34
easy_install -U distribute
# install one-by-one works better!!!
pip install -U numpy
pip install -U scipy



####
cd; cd local/OASYS
python setup.py develop
#to test: cd; python -m Orange.canvas
#ALL THE REST IS AS THE PREVIOUS VIRTUAL ENVIRONMENTS!!!



#### XKCD plots in matplotlib (required version >1.3)
sudo apt-get install gnome-font-viewer
cd ~/utils
wget http://antiyawn.com/uploads/Humor-Sans.ttf
sudo gnome-font-viewer Humor-Sans.ttf
# (click on install button, that's all for the fonts!)
# in matplotlib, any plot can be converted to xkcd via -> plt.xkcd()


### Moving to Zotero!
### http://research.coquipr.com/archives/492
### https://forums.zotero.org/discussion/25317/install-zotero-standalone-from-ubuntu-linux-mint-ppa/
sudo add-apt-repository ppa:smathot/cogscinl
sudo apt-get update
sudo apt-get install zotero-standalone qnotero





### WINE ###
sudo aptitude install wine winetricks


# Viper
cd; cd local
wget https://intranet.cells.es/Beamlines/CLAESS/software/Viper_Xanda_XAFSmass_20130226.zip
mkdir Viper; cd Viper
unzip ../Viper_Xanda_XAFSmass_20130226.zip





### TODO ###

### Utils & generic
sudo echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> /etc/apt/sources.list
sudo aptitude install virtualbox-4.2

### Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo aptitude update
sudo aptitude install google-chrome-stable

### ASE and friends
# REPOSITORY (SYSTEM APPROACH) -- NOT RECOMMENDED
# Instructions here:
# https://wiki.fysik.dtu.dk/ase/download.html#installation-with-package-manager-on-linux
sudo bash -c 'echo "deb http://download.opensuse.org/repositories/home:/dtufys/xUbuntu_12.04 /" > /etc/apt/sources.list.d/home_dtufys.sources.list'
wget http://download.opensuse.org/repositories/home:/dtufys/xUbuntu_12.04/Release.key && sudo apt-key add Release.key && rm Release.key
sudo apt-get update
sudo apt-get install python-ase gpaw gpaw-setups pycifrw pymatgen

## ==============
## Local Packages
## ==============

# Links
sudo mkdir /usr/local/maulocal
sudo chown mauro /usr/local/maulocal
cd; ln -s /usr/local/maulocal local




### XRT
# http://pythonhosted.org/xrt/
cd ~/local/
wget https://pypi.python.org/packages/source/x/xrt/xrt-0.9.4.zip#md5=53f89fe6d94b59a66bb4a66a6326f95e
unzip xrt-0.9.4.zip
# use sys.path.append('~/local/xrt-0.9.4/xrt') in your scripts


### Emacs-related (emacs24 installed system-wide via Damien Cassou PPA)

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


### FDMNES
# Simply local copy of /sware/exp/fdmnes on NICE/ESRF
#cd ~/local
#rsync -avz --delete rovezzi@rnice6-0102:/sware/exp/fdmnes
#sudo ln -s $HOME/local/fdmnes/bin/debian6/fdmnes /usr/local/bin/fdmnes

### FEFF9
# Simply local copy of /sware/exp/feff on NICE/ESRF
#cd ~/local
#rsync -avz --delete rovezzi@rnice6-0102:/sware/exp/feff
# Edit $HOME/local/feff9.6/bin/feff9 with the correct PATH_TO_FEFF9
#sudo ln -s $HOME/local/feff9.6/bin/feff9 /usr/local/bin/feff9


