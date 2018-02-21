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

#########################
#### TESTED MACHINES ####
#########################

# The following environments/procedures have been tested on:
# - debian6: beamline machines at ESRF
# - ubox1604: Xubuntu 16.04 guest in Windows 10 host (VirtualBox) 

#########################
### MINICONDA INSTALL ###
#########################
#https://conda.io/docs/test-drive.html#conda-test-drive-milestones
cd; cd $MYLOCAL
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
#installed in /home/mauro/local/conda
#not included in .bashrc
#to activate the `base` (AKA `root`) environment
source $MYLOCAL/conda/bin/activate
conda update --yes conda pip python

##############################
### PYTHON 3 MINICONDA ENV ###
##############################
#from conda root (see `MINICONDA INSTALL`)
conda create --name py36 python=3.6 #current as for June 2017
#conda create --name py35 python=3.5
source deactivate
source $MYLOCAL/conda/bin/activate py36
#add alias in .bashrc:
#alias py36='unset PYTHONPATH; $MYLOCAL/conda/bin activate py36'

##############################
### PYTHON 2 MINICONDA ENV ###
##############################
#from conda root (see `MINICONDA INSTALL`)
conda create --name py27 python=2.7
source $MYLOCAL/conda/bin/activate py27
#add alias in .bashrc:
#alias py27='unset PYTHONPATH; $MYLOCAL/conda/bin activate py27'

######################
### DEBIAN6 ISSUES ###
######################

# if glibc < 2.12 one gets a GLIBC ERROR with PyQt
# $ ldd --version
# ldd (Debian EGLIBC 2.11.3-3) 2.11.3
# /lib/libpthread.so.0: version `GLIBC_2.12' not found (required by
# /nobackup/sienne/fame/conda/envs/py27/lib/python2.7/site-packages/PyQt5/../../.././libglib-2.0.so.0)
# => SOLVED => install py27 with Miniconda2

################################
# PACKAGES INSTALLED VIA CONDA #
################################

#----
#BASE
#----
#the following packages are my conda base distribution, valid for all `py3*` and `py27*` environments
conda install -c defaults pyqt=5 qt

conda install numpy scipy matplotlib pyparsing pytz python-dateutil

conda install ipython ipykernel jupyter

conda install pyzmq h5py pandas sqlalchemy

conda install sphinx sphinxcontrib

conda install bottlechest pillow yaml termcolor requests nose swig

#-------------------
#WXPYTHON: py27 only
#-------------------
conda install wxpython

#-------------------
#OPTIONAL / WARNINGS
#-------------------
#- cython   : may generate errors
#- gcc      : from conda is NOT RECOMMENDED it may generate many errors
#             => libstdc++.so.6: version `CXXABI_1.3.9' not found
#- spyder   : may generate errors with QT
#- anaconda : will create a BIG MESS!!! DO NOT DO INSTALL IT!!!

#----------------
#WORK IN PROGRESS
#----------------
#- pyopenGL
#  conda install pyopengl pyopengl-accelerate
#- pyopenCL
#  conda install -c conda-forge pyopencl

#########################################################
# PACKAGES INSTALLED VIA CONDA FROM CONDA-FORGE CHANNEL #
#########################################################
#first activate one conda enviroment
#source $MYLOCAL/conda/bin/activate <your_environment_name>

#---------------------------------------------
#Xraylib (https://github.com/tschoonj/xraylib)
#---------------------------------------------
conda install -c conda-forge xraylib

#---------------------------------------------
#ORANGE3 (https://orange.biolab.si/)
#---------------------------------------------
conda install -c conda-forge orange3
#test if it works: `orange-canvas -l 4`

##############################
# PACKAGES INSTALLED VIA PIP #
##############################
#first activate one conda enviroment
#source $MYLOCAL/conda/bin/activate <your_environment_name>

#-------------------------------------
#Fisx (https://github.com/vasole/fisx)
#PyMca5 (http://github.com/vasole/pymca)
#Silx (http://www.silx.org)
#-------------------------------------
pip install fisx PyMca5 silx

#--------------------------------------------
#Shadow3 (https://github.com/srio/shadow3)
#--------------------------------------------
#NOTE: CURRENTLY DOES NOT WORK WITH PYTHON 3.6!!!
pip install shadow3

#---------------------------------------------
#Orange/Oasys-related
#---------------------------------------------
pip install oasys-canvas-core oasys-widget-core

#-----------------------------------------
#Lmfit (https://github.com/lmfit/lmfit-py)
#-----------------------------------------
#conda install -c conda-forge lmfit
pip install lmfit

#---------------------------------------------
#Wxmplot (https://github.com/newville/wxmplot)
#Wxutils (https://github.com/newville/wxutils)
#---------------------------------------------
#pip install wxmplot wxutils => see Larch (py27 only)

#---------------------------------------------
#Sphinx-related
#---------------------------------------------
#
#TIP: there is a bug in sphinxcontrib-googleanalytics
pip install robpol86-sphinxcontrib-googleanalytics
#
#https://github.com/ryan-roemer/sphinx-bootstrap-theme
pip install sphinx_bootstrap_theme

##################################
# PACKAGES INSTALLED FROM SOURCE #
##################################
#first activate one conda enviroment
#source $MYLOCAL/conda/bin/activate <your_environment_name>

#---------------------------------------------------------------
#Oasys (https://github.com/srio/oasys-installation-scripts/wiki)
#---------------------------------------------------------------
#REQUIREMENTS:
#- numpy             (=> conda base)
#- matplotlib        (=> conda base)
#- scipy             (=> conda base)
#- xraylib           (=> conda-forge)
#- fisx              (=> pip)
#- pymca             (=> pip)
#- silx              (=> pip)
#- shadow3           (=> pip)
#- oasys-canvas-core (=> pip)
#- oasys-widget-core (=> pip)

#srxraylib
cd $MYLOCAL
git clone https://github.com/lucarebuffi/srxraylib
cd srxraylib
pip install -e . --no-binary :all:
cd ..

#syned
cd $MYLOCAL
git clone https://github.com/lucarebuffi/syned
cd syned
python setup.py build
pip install --no-deps -e . --no-binary :all:
cd ..

#wofry
cd $MYLOCAL
git clone https://github.com/lucarebuffi/wofry
cd wofry
python setup.py build
pip install --no-deps -e . --no-binary :all:
cd ..

#oasys
cd $MYLOCAL
git clone https://github.com/lucarebuffi/oasys1
cd oasys1
python setup.py build
python setup.py develop
cd ..

#- start OASYS with this command:
#    source $MYLOCAL/conda/bin/activate pyOasys
#    python -m oasys.canvas -l4 --force-discovery
#- install all Add-Ons:
#  OASYS1-WISE
#  OASYS1-XRayServer
#  OASYS1-XOPPY
#  OASYS1-ShadowOui
#- restart oasys

#-----------------------------------------
#LARCH (http://xraypy.github.io/xraylarch)
#-----------------------------------------
#REQUIREMENTS:
#- numpy
#- scipy
#- lmfit
#OPTIONAL:
#- wx
#(using personal fork)
cd; cd $MYDEVEL
pip install wxmplot wxutils #py27 ONLY
#(using personal fork)
cd; cd devel
git clone https://github.com/maurov/xraylarch.git
cd xraylarch
git remote add --track master upstream https://github.com/xraypy/xraylarch.git
git fetch upstream
git merge upstream/master
#NOTE: wxPython is not (yet) fully supported for python3 (plotting
#      functionalities will not be available in Larch, this is to use
#      it as library)
python setup.py build
python setup.py install
# Link larch plugins directory (optional)
cd ~/.larch/
rm -rf plugins
ln -s your_larch_plugins_dir plugins

#--------------------------------------------
#XAFSmass (https://github.com/kklmn/XAFSmass)
#--------------------------------------------
cd $MYLOCAL
git clone https://github.com/kklmn/XAFSmass.git
#simpy run it via `python XAFSmassQt.py`

#----------------------------------
#XRT (https://github.com/kklmn/xrt)
#----------------------------------
#REQUIREMENTS:
#- spyder
cd $MYLOCAL
git clone https://github.com/kklmn/xrt.git
#DO NOT INSTALL VIA setup.py, simply -> sys.path.append()

#######################
### OPTIONAL METHOD ###
#######################

#--------------------------
#Silx (http://www.silx.org)
#--------------------------
#REQUIREMENTS:
#- numpy (=> conda base)
#- fisx (=> pip)
#(using personal fork)
cd; cd $MYDEVEL
git clone https://github.com/maurov/silx.git
cd silx
git remote add --track master upstream https://github.com/silx-kit/silx.git
git fetch upstream
git merge upstream/master
SPECFILE_USE_GNU_SOURCE=1 python setup.py install
#build documentation
python setup.py build_doc
#to run the tests: python -> import silx.test -> silx.test.run_tests()

#---------------------------------------
#PyMca5 (http://github.com/vasole/pymca)
#---------------------------------------
#REQUIREMENTS:
#- numpy
#- fisx
#(NOT MANDATORY: sudo apt-get install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev)
#(using personal fork)
cd; cd $MYDEVEL
git clone https://github.com/maurov/pymca.git
cd pymca
git remote add --track master upstream https://github.com/vasole/pymca.git
git fetch upstream
git merge upstream/master
python setup.py clean
SPECFILE_USE_GNU_SOURCE=1 python setup.py install
#build documentation
python setup.py build_doc
#
#TOOLTIP COLOR FIX: the tooltips will appear black on black, this is
# fixed by using `gnome-color-chooser` to set the tooltip color to a
# readable one!

#--------------------------------------------
#Shadow3 (https://github.com/srio/shadow3)
#--------------------------------------------
#
#WARNING: WEIRD BEHAVIOUR WHEN BUILT FROM SOURCE!!!
#         => USE `pip install shadow3`
#
#REQUIREMENTS:
#- gfortran
#- python <= 3.5
#- xraylib
#cd $MYLOCAL
#git clone https://github.com/srio/shadow3
#cd shadow3
#python setup.py clean
#python setup.py build
#pip install --no-deps -e . --no-binary :all:

