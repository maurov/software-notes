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

# +++++++++++++++++++++++++++++++++++++++++++ #
# debian6 is currently used at ESRF beamlines #
# +++++++++++++++++++++++++++++++++++++++++++ #

###############################
### FROM A STANDARD INSTALL ###
###############################

# Main philosophy:
# - do as much as possible as user
# - prefer system packages unless extremelly outdated
# - use python2
# - GIT sources are in /user_home/GIT

###############################
### PYTHON 2.7 IN MINICONDA ###
###############################
cd; wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
#installed in $HOME/miniconda2
source miniconda2/bin/activate root
conda create --name py27 --clone root
source deactivate
source miniconda2/bin/activate py27
conda install numpy scipy matplotlib ipython jupyter h5py pandas

pip install fisx

#######################
### PYMCA & FRIENDS ###
#######################
cd; source miniconda2/bin/activate py27; cd GIT
# update matplotlib to a working version
apt-get install -t squeeze-backports python-matplotlib
#1) ### FISX ###
# install fisx as user
git clone https://github.com/vasole/fisx
cd fisx
python setup.py install --user
#2) ### PYMCA5 ###
# install pymca from forked version (link to upstream for pairing versions)
git clone https://github.com/maurov/pymca
cd pymca
git remote add --track master upstream https://github.com/vasole/pymca.git
git fetch upstream
git merge upstream/master
SPECFILE_USE_GNU_SOURCE=1 python setup.py install --user
#3) ### SILX ###
git clone https://github.com/maurov/silx.git
cd silx
git remote add --track master upstream https://github.com/silx-kit/silx.git
git fetch upstream
git merge upstream/master
python setup.py install --user
#to run the tests: python -> import silx.test -> silx.test.run_tests()


##############################################
### TEXT EDITORs/CONVERTERS/UTILITIES/IDES ###
##############################################
#geany ide (useful for Spec macros editing)
sudo apt-get install geany

### GEDIT ###
# use python syntax highlight with SPEC files (.mac extension)
cd
mkdir .local/share/gtksourceview-2.0
mkdir .local/share/gtksourceview-2.0/language-specs
cp /usr/share/gtksourceview-2.0/language-specs/python.lang .local/share/gtksourceview-2.0/language-specs/
#edit python.lang by adding the line
#<property name="globs">.mac</property>

################
### GRAPHICS ###
################
#PINTA
sudo apt-get install pinta
