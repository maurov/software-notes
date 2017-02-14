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

#######################
### PYMCA & FRIENDS ###
#######################
cd; cd GIT
# update matplotlib to a working version
apt-get install -t squeeze-backports python-matplotlib
# install fisx as user
git clone https://github.com/vasole/fisx
cd fisx
python setup.py install --user
# install pymca from forked version (link to upstream for pairing versions)
git clone https://github.com/maurov/pymca
git remote add --track master upstream https://github.com/vasole/pymca.git
git fetch upstream
git merge upstream/master
SPECFILE_USE_GNU_SOURCE=1 python setup.py install --user

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
