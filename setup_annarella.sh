#!/bin/bash

# +++++++++++++++
# Annarella setup
# +++++++++++++++

# Annarella is a Dell Inspiron 1501 laptop
# The starting point is a fresh Xubuntu 12.04.4 installation

## System Packages
## ===============

### Hardware for Inspiron
sudo aptitude remove bcmwl-kernel-source
sudo aptitude install b43-fwcutter firmware-b43-installer
# Remove ATI fglrx driver
sudo apt-get remove fglrx fglrx-amdcccle --purge

### 3D and OpenGL
sudo apt-get install mesa-utils freeglut3 freeglut3-dev binutils-gold

### Revision control (Git & friends)
sudo apt-get install git meld gftp
#subversion
# Dropbox better if downloaded directly
sudo apt-get remove nautilus-dropbox --purge
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb
sudo dpkg -i dropbox_1.6.0_amd64.deb
#$ dropbox start -i

### BLAS/ATLAS
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

### Qt
sudo aptitude install qt4-dev-tools qt4-designer

### Python 2
sudo aptitude install python-pip python-setuptools
sudo aptitude install python-matplotlib python-scipy python-sphinx python-docutils python-h5py
sudo aptitude install python-sympy python-pandas python-openbabel python-sqlalchemy python-lxml
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
### brewer2mpl
pip install brewer2mpl --user

### Python 3.2 (on Ubuntu 12.04)
sudo aptitude install python3-setuptools python3-numpy python3-scipy
sudo aptitude install python3-nose python3-mock
sudo aptitude install python3-pyqt4 python-qt4-dev python3-sip-dev libqt4-dev
sudo aptitude install ipython3 ipython3-qtconsole python3-sphinx python3-jinja2

### Python 3.2 local virtual environment
cd; cd local
virtualenv -p python3 --system-site-packages --distribute py3env
source py3env/bin/activate
easy_install -U distribute
#NOTE: ipython and sphinx last versions require python >=2.7 or >=3.3
pip install -U numpy==1.9.1
pip install -U scipy==0.15.0
pip install -U scikit-learn==0.15.2
pip install -U bottlechest==0.7.0
pip install -U nose==1.3.4 mock==1.0.1
pip install -U ipython==0.13.2
#newer versions work only with >=3.3 and 0.12.1 has a bug in the --gui threads
pip install -U matplotlib==1.4.2
# deps 'six python-dateutil pyparsing' should be installed by default
pip install -U pandas==0.15.2
sudo apt-get install libhdf5-serial-dev
pip install -U h5py==2.4.0
pip install -U sympy
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

#### XKCD plots in matplotlib (required version >1.3)
sudo apt-get install gnome-font-viewer
cd ~/utils
wget http://antiyawn.com/uploads/Humor-Sans.ttf
sudo gnome-font-viewer Humor-Sans.ttf
# (click on install button, that's all for the fonts!)
# in matplotlib, any plot can be converted to xkcd via -> plt.xkcd()

### Editor (Emacs & friends)
sudo add-apt-repository ppa:cassou/emacs
sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
sudo aptitude install fonts-inconsolata aspell-en aspell-fr aspell-it

#### LaTeX editor (for LaTeX distribution see in local)
sudo aptitude install texworks

### Office (Libreoffice & friends)
sudo apt-get remove abiword gnumeric --purge
sudo add-apt-repository ppa:libreoffice/libreoffice-4-2
sudo aptitude install libreoffice libreoffice-pdfimport
sudo aptitude install libreoffice-l10n-en-gb myspell-en-gb hyphen-en-gb mythes-en-us libreoffice-help-en-gb
sudo aptitude install libreoffice-l10n-fr myspell-fr hyphen-fr mythes-fr
sudo aptitude install libreoffice-l10n-it myspell-it hyphen-it mythes-it 

### Graphics (Inkscape & friends)
sudo add-apt-repository ppa:inkscape.dev/stable
sudo aptitude install inkscape xclip graphviz

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
#ln -s utils/Mendeley\ Desktop.conf .config/Mendeley\ Ltd./Mendeley\ Desktop.conf
# Mendely does not like to work with a link, for some strange reason one has to copy the configuration file!
cp utils/Mendeley\ Desktop.conf .config/Mendeley\ Ltd./Mendeley\ Desktop.conf

### Moving to Zotero!
### http://research.coquipr.com/archives/492
### https://forums.zotero.org/discussion/25317/install-zotero-standalone-from-ubuntu-linux-mint-ppa/
sudo add-apt-repository ppa:smathot/cogscinl
sudo apt-get update
sudo apt-get install zotero-standalone qnotero

### Web
# default flash plugin does not always work properly... Adobe one is better
sudo aptitude install flashplugin-installer

### Email
# I do not like Thunderbird, Claws Mail is preferred!
sudo aptitude remove thunderbird thunderbird-globalmenu
# add more recent PPA for Claws Mail
sudo add-apt-repository ppa:claws-mail/ppa
sudo apt-get update
sudo aptitude install claws-mail claws-mail-extra-plugins

#### alternative (TODO)
# offlineimap
# Wander Lust  ???  http://www.emacswiki.org/emacs/WanderLust

# Multimedia
sudo apt-get install vlc avidemux openshot

### Ifeffit & Friends
# better to use old version until Demeter will fully work with Larch
sudo aptitude install horae ifeffit

### VESTA


### TODO ###

### Utils & generic
sudo echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> /etc/apt/sources.list
sudo aptitude install virtualbox-4.2

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

## ==============
## Local Packages
## ==============

# Links
sudo mkdir /usr/local/maulocal
sudo chown mauro /usr/local/maulocal
cd; ln -s /usr/local/maulocal local

### LaTeX (Texlive 2014)
# https://github.com/scottkosty/install-tl-ubuntu
cd local; git clone https://github.com/scottkosty/install-tl-ubuntu.git
cd install-tl-ubuntu; sudo ./install-tl-ubuntu
# restart computer

### PyMca5
cd ~/local/
sudo aptitude install python-qt4 python-qt4-dev
# fisx
git clone https://github.com/vasole/fisx.git
cd fisx
python setup.py install --user

git clone https://github.com/vasole/pymca.git
cd pymca

# SYSTEM-WIDE INSTALL
#not recommended, better user install (see below)
#sudo SPECFILE_USE_GNU_SOURCE=1 python setup.py install
# make CLEAN:
#(sudo) rm -rf /usr/local/lib/python2.7/dist-packages/PyMca*
#(sudo) rm -rf ~/local/pymca/build/
#
# USER INSTALL: standard (in .local/lib/python2.7/site-packages/)
SPECFILE_USE_GNU_SOURCE=1 python setup.py install --user

# USER INSTALL: virtual environment
# (in_your_virt_env) SPECFILE_USE_GNU_SOURCE=1 python setup.py build
# (in_your_virt_env) python setup.py install

# documentation
python setup.py build_doc

### PyMca 4.7
cd ~/local/
sudo aptitude install libqwt5-qt4 libqwt-dev python-qwt5-qt4
svn checkout http://svn.code.sf.net/p/pymca/code/ pymca-code
cd pymca-code
sudo SPECFILE_USE_GNU_SOURCE=1 python setup.py install


### XRT
# http://pythonhosted.org/xrt/
cd ~/local/
wget https://pypi.python.org/packages/source/x/xrt/xrt-0.9.4.zip#md5=53f89fe6d94b59a66bb4a66a6326f95e
unzip xrt-0.9.4.zip
# use sys.path.append('~/local/xrt-0.9.4/xrt') in your scripts

### XOP/SHADOW3
export MYLOCAL=~/local/
cd $MYLOCAL
wget http://ftp.esrf.eu/pub/scisoft/xop2.3/xop2.3_Linux_20140616.tar.gz
tar xzvf xop2.3_Linux_20140616.tar.gz
export XOP_HOME=$MYLOCAL/xop2.3
cd $MYLOCAL
mkdir xop_extensions
cd xop_extensions
wget http://ftp.esrf.eu/pub/scisoft/xop2.3/shadowvui1.12_Linux_20140708.tar.gz
tar xzvf shadowvui1.12_Linux_20140708.tar.gz
cd $MYLOCAL/xop2.3/extensions
ln -s $MYLOCAL/xop_extensions/shadowvui shadowvui
cd shadow3
# IF YOU WANT TO UPDATE SHADOW3 TO THE LAST VERSION
# git pull
# OR if this does not work:
#    cd ..; rm -rf shadow3;
#    git clone git://git.epn-campus.eu/repositories/shadow3
#    cd shadow3
# THEN BUILD THE PYTHON LIBRARY
make python
export SHADOW3_HOME=$MYLOCAL/xop_extensions/shadowvui/shadow3
export SHADOW3_BUILD=$SHADOW3_HOME/build/lib.linux-x86_64-2.7
export LD_LIBRARY_PATH=$SHADOW3_HOME:$LD_LIBRARY_PATH
export PYTHONPATH=$SHADOW3_BUILD:$PYTHONPATH

# TIPS:
# run shadow with 'xop shadowvui'
# put all previous environment variables in .bashrc
sudo ln -s $MYLOCAL/xop2.3/xop /usr/local/bin/xop

### Emacs-related (emacs24 installed system-wide via Damien Cassou PPA)
cd; ln -s utils/software-notes/mydotemacs24U1204 .emacs
mkdir ~/local/emacs
cd ~/local/emacs
ln -s /media/sf_WinLinShare/utils/mydotemacs .emacs
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

### Larch 
#Instructions: http://xraypy.github.com/xraylarch/downloads/index.html#source-installation
#### Deps:
sudo aptitude install python-wxgtk2.8 python-wxtools python-setuptools python-docutils python-h5py python-sqlalchemy
#sudo easy_install wxmplot
pip install --user -U wxmplot wxutils termcolor
cd ~/local
git clone http://github.com/xraypy/xraylarch.git
cd xraylarch
python setup.py build
## local install not working!!!
##nano lib/site_configdata.py
## unix_installdir = '/home/mauro/.local/share/larch'
# 
sudo python setup.py install
#sudo python setup.py install
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

## Workflows
## =========

## Links
sudo mkdir /media/sf_WinLinShare
sudo chown mauro /media/sf_WinLinShare/
ln -s /home/mauro/biblio /media/sf_WinLinShare/biblio
ln -s /home/mauro/utils /media/sf_WinLinShare/utils
ln -s /home/mauro/WORK12 /media/sf_WinLinShare/WORK12
ln -s /home/mauro/WORK11 /media/sf_WinLinShare/WORK11

## BASH VARIABLES
## ==============
## see: mydotbashrcU1204

