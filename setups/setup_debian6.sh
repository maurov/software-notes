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

########################
### PYTHON & FRIENDS ###
########################

# Python-related software is installed via Conda environments
# => setup_conda_envs.sh

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
