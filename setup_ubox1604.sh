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
# see: mydotbashrcU1604.sh

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
sudo apt-get install dkms build-essential module-assistant autoconf shtool libtool swig
sudo m-a prepare
# mount the Guest Additions cdrom and run VBoxLinuxAdditions.run as root
#sudo sh /path/to/VobLinuxAdditions.run

#########################
# WORKFLOWS/DIRECTORIES #
#########################
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
#local software repository -> $MYLOCAL
cd; mkdir local
export MYLOCAL=~/local/

#############
# PACKAGING #
#############
sudo apt-get install aptitude synaptic gdebi-core

###############
# BUILD TOOLS #
###############
sudo aptitude install gfortran cython cython3 cython-doc

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
#Spacemacs variant -> TOO DISTRACTING // REMOVED!!!
#cd; rm -rf .emacs.d; rm .emacs
#git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
#start in http mode, otherwise will not correctly install
#emacs --insecure

####################################
### GRAPHICS: INKSCAPE & FRIENDS ###
####################################
sudo aptitude install inkscape xclip graphviz

###############
### TEXLIVE ###
###############
#a sub-selection from texlive-full package
sudo aptitude install texlive-lang-french texlive-science-doc texlive-generic-recommended texlive-latex-extra texlive-formats-extra latexdiff texlive-binaries texlive-base texlive-latex-recommended lcdf-typetools texlive-fonts-recommended-doc texlive-pstricks-doc texlive-font-utils texlive-humanities-doc context texlive-htmlxml texlive-metapost-doc texlive-metapost texlive-pstricks purifyeps dvidvi texlive-generic-extra prosper texlive-publishers texlive-science fragmaster texlive-lang-italian texlive-fonts-recommended texlive-lang-english texlive-latex-extra-doc prerex texlive-humanities texinfo texlive-xetex texlive-fonts-extra-doc texlive-math-extra texlive-luatex feynmf texlive-fonts-extra texlive-plain-extra texlive-publishers-doc chktex texlive-extra-utils lmodern tex4ht texlive-pictures-doc psutils tex-gyre texlive-games texlive-latex-base dvipng texlive-omega latexmk lacheck tipa texlive-music texlive-latex-recommended-doc texlive-latex-base-doc texlive-pictures texlive-bibtex-extra t1utils xindy

#give you the rights on texlive
sudo chown -R mauro.users /usr/share/texlive
#install non free fonts
wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
sudo texlua ./install-getnonfreefonts -a
getnonfreefonts -a

##################
### MULTIMEDIA ###
##################
#encoders
sudo aptitude install ffmpeg mencoder
#VLC & FRIENDS ###
sudo aptitude install vlc avidemux openshot
#jdownloader: http://jdownloader.org/
#https://launchpad.net/~jd-team/+archive/ubuntu/jdownloader
sudo add-apt-repository ppa:jd-team/jdownloader
sudo apt-get update
sudo apt-get install jdownloader-installer

##########
### QT ###
##########
#QT4
sudo aptitude install python3-pyqt4 qt4-dev-tools libqt4-dev libqt4-opengl
#QT5
sudo aptitude install qt5-default qt5-doc qttools5-dev-tools qtcreator pyqt5-dev pyqt5-doc pyqt5-examples pyqt5-dev-tools python-pyqt5 python3-pyqt5 python-pyqt5.qtsvg python3-pyqt5.qtsvg

#######################################
### PYTHON3.5 : VIRTUAL ENVIRONMENT ###
#######################################
cd; cd $MYLOCAL
python3.5 -m venv py35 --clear --without-pip --system-site-packages
source py35/bin/activate
cd py35; wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install --upgrade pip setuptools distribute

#Numpy
sudo apt-get -y install python3-dev g++ libblas-dev liblapack-dev gfortran
pip install -U numpy 
#check version: python -> import numpy -> numpy.version.version

#Scipy
pip install -U scipy
#check version: python -> import scipy -> scipy.version.version

#Sympy
pip install -U sympy

#Bottlechest
#NOTE: pip install does not work, better directly from sources
git clone https://github.com/biolab/bottlechest
cd bottlechest
python setup.py install
cd ..

#Matplotlib
#NOTE: the packages are to solve a known bug in building matplolib from pip
sudo apt-get install libfreetype6-dev libxft-dev libpng-dev
pip install -U matplotlib
#check version: python -> import matplotlib -> matplotlib.__version__

#IPython & friends
pip install -U pygments pyzmq ipython qtconsole jupyter

#Pandas
pip install -U pandas

#H5py
sudo aptitude install libhdf5-dev
pip install -U h5py

#Utils
pip install -U six sqlalchemy palettable termcolor seaborn

#LARCH (http://xraypy.github.io/xraylarch)
#build/install for python3
cd; cd local
#(using personal fork)
git clone https://github.com/maurov/xraylarch.git
#NOTE: wxPython is not supported for python3 (plotting functionalities
#      will not be available in Larch, this is to use it as library)
python setup.py build
python setup.py install
# Link larch plugins directory (optional)
cd ~/.larch/
rm -rf plugins
ln -s your_larch_plugins_dir plugins

#PyMca5
cd; cd ~/local/
# fisx (it will be done at pymca setup!)
#(using personal fork)
git clone https://github.com/maurov/pymca.git
cd pymca
SPECFILE_USE_GNU_SOURCE=1 python setup.py install --fisx
#build documentation
python setup.py build_doc

#Silx
cd; cd ~/local/
# fisx (it will be done at pymca setup!)
#(using personal fork)
git clone https://github.com/maurov/silx.git
cd silx
python setup.py 
#build documentation
python setup.py build_doc

# Orange
pip install -U chardet nose Jinja2 Sphinx recommonmark numpydoc beautifulsoup4 xlrd
pip install -U orange-canvas-core orange-widget-core

# Xraylib
#(https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_virtual_environment.sh)
wget https://github.com/tschoonj/xraylib/archive/xraylib-3.1.0.tar.gz
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
cd; cd local
git clone https://github.com/lucarebuffi/srxraylib
cd srxraylib
python setup.py install
cd ..

### SHADOW3 (with python 3.4)
cd; cd local
git clone https://github.com/srio/shadow3.git
cd shadow3
python setup.py build
python setup.py develop

#ShadowOui
#(https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_virtual_environment.sh)
git clone https://github.com/lucarebuffi/oasys1
cd oasys1
python setup.py develop
cd ..
git clone https://github.com/lucarebuffi/shadowOui
cd shadowOui
python setup.py develop
cd ..

