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

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ubox1604 is XUbuntu 16.04 VirtuaBox guest in a Windows host #
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# /!\ the best Ubuntu flavor is XUbuntu /!\ #

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

#GUIDE: How to configure network in the guest OS in order to work with VPN
#https://superuser.com/questions/987150/virtualbox-guest-os-through-vpn/1035327

#########################
# WORKFLOWS/DIRECTORIES #
#########################
# if migrating from existing machine/install
# -> manually copy 'WinLinShare' to DATA partition
# Links with VirtualBox shared folders
# sudo mkdir /media/sf_WinLinShare
sudo chown mauro /media/sf_WinLinShare/
# symbolic link everything in $HOME
cd $HOME
ln -s /media/sf_WinLinShare/biblio biblio
ln -s /media/sf_WinLinShare/utils utils
#ln -s /media/sf_WinLinShare/ownClowd/WORKtmp WORKtmp
ln -s /media/sf_WinLinShare/Dropbox/WORKtmp WORKtmp
ln -s /media/sf_WinLinShare/WORK* WORK*
export $MYMENDELEYLOCAL=/media/sf_WinLinShare/MendeleyLocal

#local software -> $MYLOCAL
cd; mkdir local
export MYLOCAL=~/local/
#devel software -> $MYDEVEL
cd; mkdir devel
export MYDEVEL=~/devel/

################
# COLOR THEMES #
################
sudo apt-get install gnome-color-chooser

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
#git config --global user.name "Mauro Rovezzi"
#git config --global user.email "mauro.rovezzi@gmail.com"

########################
# EMAIL -> THUNDERBIRD #
########################
sudo aptitude install thunderbird thunderbird-globalmenu
#WORKFLOW (Linux):
#- to keep local config, link .thunderbird -> /media/sf_WinLinShare/dotThunderbird
#- mail dir is '/media/sf_WinLinShare/MailThunderbird
#- calendaring seems broken under Linux!
#- better to create new profiles, run with "thunderbird -p"
#- MIGRATE TO NEW PROFILE: http://kb.mozillazine.org/Transferring_data_to_a_new_profile_-_Thunderbird
#- prefer Maildir format instead of Mbox:
#  menu -> preferences -> preferences -> advanced (general tab) -> Message Store Type for new accounts (Maildir)
#WORKFLOW (Windows):
#- Thunderbirb seems to work better under Windows
#- to show the conf directory go to Help -> troubleshooting ...
#
#TO SHOW CONFIG EDITOR:
#menu -> preferences -> preferences -> advanced (general tab) -> config editor
#some useful settings:
#opening external links
#network.protocol-handler.expose.* (True)
#network.protocol-handler.warn-external.* (True)
#enable threaded view by default
#mailnews.default_view_flags (1)

### UTILTS ###
sudo apt-get install mb2md

##########################################
### REFERENCE MANAGER: MENDELEY/ZOTERO ###
##########################################
# Mendeley
sudo apt-get install libqtwebkit4 libqtsvg4-perl
wget http://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
sudo dpkg -i mendeleydesktop-latest
#Initial setup by simply profiding your login details
mendeleydesktop
#Quit and TRANSFER YOUR LOCAL VERSION
#NOTE: Mendeley does not like to work with links, one have to make a real copy!
#1) copy database
rsync -avz --delete $MYMENDELEYLOCAL/dotLocalShareData/ $HOME/.local/share/data/Mendeley\ Ltd./
rsync -avz --delete $MYMENDELEYLOCAL/dotLocalShare/ $HOME/.local/share/Mendeley\ Ltd./
#2) copy settings file
rsync -avz --delete $MYMENDELEYLOCAL/dotConfig/ $HOME/.config/Mendeley\ Ltd./
#3) copy cache
rsync -avz --delete $MYMENDELEYLOCAL/dotCache/ $HOME/.cache/Mendeley\ Ltd./
#4) start Mendeley and everything should be in place!

### ZOTERO ###
#using qnotero repository
sudo add-apt-repository ppa:smathot/cogscinl
sudo apt-get update
sudo apt-get install zotero-standalone
#install the firefox extension
#synchronize files using webDAV
#(owncloud has this option, use the link you get in `settings` tab from the web interface)


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

###################
### LIBREOFFICE ###
###################
sudo apt-add-repository ppa:libreoffice/ppa
sudo apt-get update
sudo apt-get install libreoffice-calc libreoffice-dmaths libreoffice-draw libreoffice-math libreoffice-pdfimport libreoffice-l10n-en-gb myspell-en-gb hyphen-en-gb mythes-en-us libreoffice-help-en-gb libreoffice-l10n-fr libreoffice-script-provider-python libreoffice-style-tango libreoffice-templates libreoffice-voikko libreoffice-wiki-publisher libreoffice-writer libreoffice-writer2latex myspell-fr hyphen-fr mythes-fr libreoffice-l10n-it myspell-it hyphen-it mythes-it libxrender1 libgl1 openclipart-libreoffice openclipart2-libreoffice pstoedit imagemagick libpaper-utils

####################################
### GRAPHICS: INKSCAPE & FRIENDS ###
####################################
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt-get update
sudo apt-get install inkscape xclip graphviz

#PINTA
sudo apt-get install pinta

#GIMP
sudo apt-get install gimp
#cd in .gimp-XX/scripts/
wget http://registry.gimp.org/files/arrow.scm
#

####################
### TEXLIVE 2016 ###
####################
sudo add-apt-repository ppa:jonathonf/texlive
#a sub-selection from texlive-full package
sudo aptitude install texlive-lang-french texlive-science-doc texlive-generic-recommended texlive-latex-extra texlive-formats-extra latexdiff texlive-binaries texlive-base texlive-latex-recommended lcdf-typetools texlive-fonts-recommended-doc texlive-pstricks-doc texlive-font-utils texlive-humanities-doc context texlive-htmlxml texlive-metapost-doc texlive-metapost texlive-pstricks purifyeps dvidvi texlive-generic-extra prosper texlive-publishers texlive-science fragmaster texlive-lang-italian texlive-fonts-recommended texlive-lang-english texlive-latex-extra-doc prerex texlive-humanities texinfo texlive-xetex texlive-fonts-extra-doc texlive-math-extra texlive-luatex feynmf texlive-fonts-extra texlive-plain-extra texlive-publishers-doc chktex texlive-extra-utils lmodern tex4ht texlive-pictures-doc psutils tex-gyre texlive-games texlive-latex-base dvipng texlive-omega latexmk lacheck tipa texlive-music texlive-latex-recommended-doc texlive-latex-base-doc texlive-pictures texlive-bibtex-extra t1utils xindy
#give you the rights on texlive
sudo chown -R mauro.users /usr/share/texlive
#install non free fonts
wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts
sudo texlua ./install-getnonfreefonts -a
getnonfreefonts -a
#lyx
sudo aptitude install lyx fonts-lyx elyxer

### CONVERT LaTeX to MS Word
#1) latex2rft (best)
sudo apt-get install latex2rtf latex2rtf-doc
#2) pandoc (alternative)
sudo apt-get install pandoc pandoc-citeproc pandoc-data python-pandocfilters python3-pandocfilters

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
#if the first run fails, download JD2Setup_x64.sh from their website
#the install manually: ./JD2Setup_x64.sh (chmod +x first)

########################
### PYTHON & FRIENDS ###
########################

# Python-related software is installed via Conda environments
# => setup_conda_envs.sh

##################################################################################
# DEPRECATED: in my current workflow all QT, Python & friends is done with CONDA #
##################################################################################

##########
### QT ###
##########
#QT4
sudo aptitude install python3-pyqt4 qt4-dev-tools libqt4-dev libqt4-opengl qt4-designer
#QT5 (preferred)
sudo aptitude install qt5-default qt5-doc qttools5-dev-tools qtcreator pyqt5-dev pyqt5-doc pyqt5-examples pyqt5-dev-tools python-pyqt5 python3-pyqt5 python-pyqt5.qtsvg python-pyqt5.qtwebkit python3-pyqt5.qtsvg python3-pyqt5.qtwebkit python3-pyqt5.qtopengl libqt5opengl5-dev qtcreator

###################################
### PYTHON2.7 : SYSTEM PACKAGES ###
###################################
sudo aptitude install python-numpy python-scipy python-matplotlib python-pytools python-pyopencl

###################################
### PYTHON3.5 : SYSTEM PACKAGES ###
###################################
sudo aptitude install python3-pytools python3-pyopencl python3-opengl

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

#Matplotlib
#NOTE: the packages are to solve a known bug in building matplolib from pip
sudo apt-get install libfreetype6-dev libxft-dev libpng-dev
pip install -U matplotlib
#check version: python -> import matplotlib -> matplotlib.__version__

#Bottlechest
#NOTE: pip install does not work, better directly from sources
git clone https://github.com/biolab/bottlechest
cd bottlechest
python setup.py install
cd ..

#IPython & friends
pip install -U pygments pyzmq ipython qtconsole jupyter

#H5py
sudo aptitude install libhdf5-dev
pip install -U h5py

#Pandas
pip install -U pandas

#Sphinx
pip install -U sphinx

#Utils
pip install -U six sqlalchemy palettable termcolor seaborn pytools

#LARCH (http://xraypy.github.io/xraylarch)
#build/install for python3
pip install -U lmfit nose
#(using personal fork)
cd; cd devel
git clone https://github.com/maurov/xraylarch.git
cd xraylarch
git remote add --track master upstream https://github.com/xraypy/xraylarch.git
git fetch upstream
git merge upstream/master
#NOTE: wxPython is not supported for python3 (plotting functionalities
#      will not be available in Larch, this is to use it as library)
python setup.py build
python setup.py install
# Link larch plugins directory (optional)
cd ~/.larch/
rm -rf plugins
ln -s your_larch_plugins_dir plugins

#PyMca5
pip install -U fisx
#(using personal fork)
cd; cd devel
git clone https://github.com/maurov/pymca.git
cd pymca
git remote add --track master upstream https://github.com/vasole/pymca.git
SPECFILE_USE_GNU_SOURCE=1 python setup.py install
#build documentation
python setup.py build_doc
#
#TOOLTIP COLOR FIX: the tooltips will appear black on black, this is
# fixed by using `gnome-color-chooser` to set the tooltip color to a
# readable one!

#Silx
pip install -U fisx
#(using personal fork)
cd; cd devel
git clone https://github.com/maurov/silx.git
cd silx
git remote add --track master upstream https://github.com/silx-kit/silx.git
git fetch upstream
git merge upstream/master
python setup.py install
#build documentation
python setup.py build_doc
#to run the tests: python -> import silx.test -> silx.test.run_tests()

# Orange
pip install -U chardet nose Jinja2 Sphinx recommonmark numpydoc beautifulsoup4 xlrd
pip install -U orange-canvas-core orange-widget-core

# Xraylib
#(https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_virtual_environment.sh)
pip install http://ftp.esrf.eu/pub/scisoft/Oasys/pip/xraylib-3.1.tar.gz

#NOT WORKING!!!
#https://github.com/srio/oasys-installation-scripts/blob/master/update_xraylib_from_github.sh
#export PYTHON_SITE_PACKAGES=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
#git clone https://github.com/tschoonj/xraylib
#cd xraylib
#autoreconf -i 
#./configure --enable-python --enable-python-integration PYTHON=`which python`
#make
#cp python/xrayhelp.py $PYTHON_SITE_PACKAGES 
#cp python/xraylib.py $PYTHON_SITE_PACKAGES 
#cp python/.libs/xraylib_np.so $PYTHON_SITE_PACKAGES
#cp python/.libs/_xraylib.so $PYTHON_SITE_PACKAGES
#cp python/xraymessages.py $PYTHON_SITE_PACKAGES 
#cd ..

#SRxraylib
cd; cd local
git clone https://github.com/lucarebuffi/srxraylib
cd srxraylib
pip install -e . --no-binary :all:
cd ..

#SHADOW3
cd; cd local
git clone https://github.com/srio/shadow3
cd shadow3
python setup.py build
pip install -e . --no-binary :all:
cd ..

#Syned (Oasys dependency)
cd; cd local
git clone https://github.com/lucarebuffi/syned
cd syned
pip install -e . --no-binary :all:

#Wofry (Oasys dependency)
cd; cd local
git clone https://github.com/lucarebuffi/wofry
cd wofry
pip install -e . --no-binary :all:

#Oasys
cd; cd local
git clone https://github.com/lucarebuffi/oasys1
cd oasys1
pip install -e . --no-binary :all:
cd ..
#insert this in .bashrc
#alias oasys='source $MYLOCAL/py35/bin/activate; python -m oasys.canvas -l4 --force-discovery'


### CRYSTAL
cd; cd local
git clone https://github.com/srio/CRYSTAL
cd CRYSTAL
make
#insert this in .bashrc
export DIFFPAT_EXEC=$MYLOCAL/CRYSTAL/diff_pat

### PYTHON WRAPPERS FOR CLOUD APIs ###
https://github.com/realpython/list-of-python-api-wrappers
#common
sudo aptitude install python3-openssl #installing by pip fails at cryptography!!!
pip install --upgrade oauth2client

#Google Python API
#https://developers.google.com/sheets/api/quickstart/python
pip install --upgrade google-api-python-client
#simpler to work with pygsheets: https://github.com/nithinmurali/pygsheets
#(was gspread: https://github.com/burnash/gspread)
#
cd; cd local
git clone https://github.com/nithinmurali/pygsheets

########################################################
### PRODUCTIVITY - TIME TRACKING - TOGGL.COM DESKTOP ###
########################################################
# From GITHUB, build instructions at: https://github.com/toggl/toggldesktop
# /!\ FOR LIVE SERVERS /!\ : https://github.com/toggl/toggldesktop/wiki/Building-Toggl-Desktop-from-source-for-usage-with-live-servers
#cd; cd local
#git clone https://github.com/toggl/toggldesktop
# FROZEN: still not conviced the desktop application is better than the web one...
