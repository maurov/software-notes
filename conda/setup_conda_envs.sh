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


###############
### WARNING ###
###############

#2018-07-07: THIS FILE IS NOT *ACTIVELY* UPDATED ANYMORE:
#
#---> https://github.com/maurov/xraysloth/blob/master/environment.yml
#---> https://github.com/maurov/xraysloth/blob/master/environment-dev.yml

#########################
#### TESTED MACHINES ####
#########################

# The following environments/procedures have been tested on:
# - debian6: beamline machines at ESRF
# - ubox1604: Xubuntu 16.04 guest in Windows 10 host (VirtualBox) 

##########################
#### WINDOWS MACHINES ####
##########################

#pyopencl and pyopengl should be pip installed via wheels from:
#https://www.lfd.uci.edu/~gohlke/pythonlibs/

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
conda create --name py36 python=3.6 #current as for 2018-03-22
source deactivate
source $MYLOCAL/conda/bin/activate py36
#add alias in .bashrc:
#alias py35='unset PYTHONPATH; $MYLOCAL/conda/bin activate py36'

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

#-----------
#BASE/COMMON
#-----------
#base/common distribution, valid for all `py3*` and `py27*` environments
#level0
conda install --yes -c defaults pyqt=5 qt
conda install --yes numpy scipy matplotlib pillow six bottlechest
conda install --yes ipython ipykernel jupyter pyzmq pandas pyyaml h5py
#level1
conda install --yes pytz python-dateutil requests termcolor nose swig dill
conda install --yes scikit-learn pyparsing  sqlalchemy
conda install --yes sphinx sphinxcontrib 
conda install --yes wxpython

#-------------------
#OPTIONAL / WARNINGS
#-------------------
conda install cython
#- cython   : may generate errors / NOTE: required to build silx from source
#- gcc      : it may generate errors (reported below what seen so far)
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

#----------------------------------------------
#ASE (https://wiki.fysik.dtu.dk/ase/index.html)
#----------------------------------------------
conda install -c conda-forge ase

#---------------------------------------------
#ORANGE3 (https://orange.biolab.si/)
#---------------------------------------------
#NOTE: **conficts** with OASYS1!!!
#conda install -c conda-forge orange3
#test if it works: `orange-canvas -l 4`

#-----------------------------------------
#Larch-related
#-----------------------------------------
#peakutils
#lmfit (https://github.com/lmfit/lmfit-py)
#asteval
#psutil
#pytest
#uncertainties
#-----------------------------------------
conda install -c conda-forge peakutils lmfit asteval psutil pytest uncertainties

#######################################################
# PACKAGES INSTALLED VIA CONDA FROM SPECIFIC CHANNELS #
#######################################################
#first activate one conda enviroment
#source $MYLOCAL/conda/bin/activate <your_environment_name>

#------------------------
# pymatgen (pymatgen.org)
#------------------------
conda install --channel matsci pymatgen

##############################
# PACKAGES INSTALLED VIA PIP #
##############################
#first activate one conda enviroment
#source $MYLOCAL/conda/bin/activate <your_environment_name>

#-----------------------------------------
#wxmplot (https://github.com/newville/wxmplot)
#wxutils (https://github.com/newville/wxutils)
#-----------------------------------------
pip install wxmplot wxutils

#-------------------------------------
#Fisx (https://github.com/vasole/fisx)
#PyMca5 (http://github.com/vasole/pymca)
#PyCifRW (https://www.iucr.org/resources/cif/software/pycifrw)
#Silx (http://www.silx.org)
#-------------------------------------
pip install fisx PyMca5
pip install hdf5plugin PyCifRW
pip install fabio hdf5plugin pyFAI
#pip install silx #currently the source install is preferred (see below)

#--------------------------------------------
#Shadow3 (https://github.com/srio/shadow3)
#--------------------------------------------
#pip install shadow3 (not always working, better use the wheel below!!!)
pip install http://ftp.esrf.eu/pub/scisoft/shadow3/wheels/shadow3-18.1.24-cp35-cp35m-linux_x86_64.whl #py35
pip install http://ftp.esrf.eu/pub/scisoft/shadow3/wheels/shadow3-18.1.24-cp36-cp36m-linux_x86_64.whl #py36

#---------------------------------------------
#Orange/Oasys-related
#---------------------------------------------
pip install oasys-canvas-core oasys-widget-core oasys1 srxraylib syned wofry

#---------------------------------------------
#Sphinx-related
#---------------------------------------------
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
#- oasys1            (=> pip)
#- srxraylib         (=> pip) 
#- syned	     (=> pip) 
#- wofry	     (=> pip)

# wofryshadow
cd $MYLOCAL
git clone https://github.com/srio/wofryshadow
cd wofryshadow
pip install -e . --no-deps --no-binary :all:
cd ..

#shadowOui
cd $MYLOCAL
git clone https://github.com/lucarebuffi/shadowOui
cd shadowOui
pip install -e . --no-deps --no-binary :all:
python setup.py develop
cd

#- start OASYS with this command:
#    source $MYLOCAL/conda/bin/activate py35
#    python -m oasys.canvas -l4 --force-discovery
#- DO NOT install Add-Ons, they should be already there!!!

#-----------------------------------------
#LARCH (http://xraypy.github.io/xraylarch)
#-----------------------------------------
#REQUIREMENTS:
#- numpy         (=> conda)
#- scipy         (=> conda)
#- matplotlib    (=> conda)
#- sqlalchemy    (=> conda)
#- h5py          (=> conda)
#- pillow        (=> conda)
#- requests      (=> conda)
#- wxpython      (=> conda)
#- pyyaml        (=> conda)
#- lmfit         (=> conda-forge)
#- peakutils     (=> conda-forge)
#- asteval       (=> conda-forge)
#- psutil        (=> conda-forge)
#- pytest        (=> conda-forge)
#- wxmplot       (=> pip)
#- wxutils       (=> pip)
#- fisx          (=> pip)
#- silx          (=> pip)
#- PyMca5        (=> pip)
#- fabio         (=> pip)
#- hdf5plugin    (=> pip)
#- PyCifRW       (=> pip)
#- uncertainties (=> pip)
#(using personal fork)
cd; cd $MYDEVEL
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


#----------------------------------
#XRT (https://github.com/kklmn/xrt)
#----------------------------------
#REQUIREMENTS:
#- qt>=5.7
#- pyqt=5                     (=> conda)
#- numpy>=1.8.0               (=> conda)
#- scipy>=0.17.0              (=> conda)
#- matplotlib>=2.0.0          (=> conda)
#- spyder>=3.0.0              (=> conda)
#- Sphinx>=1.6.2              (=> conda)
#- pyopengl>=3.1.1            (=> conda)
#- pyopengl-accelerate>=3.1.1 (=> anaconda)
#(using personal fork)
cd; cd $MYDEVEL
git clone https://github.com/maurov/xrt.git
cd xrt
git remote add --track master upstream https://github.com/kklmn/xrt.git
git fetch upstream
git merge upstream/master
#DO NOT INSTALL VIA setup.py, simply -> sys.path.append()
#latest tests in WORKtmp/_python/xrt/xrt_mytest_v1811.py

#--------------------------------------------
#XAFSmass (https://github.com/kklmn/XAFSmass)
#--------------------------------------------
cd $MYLOCAL
git clone https://github.com/kklmn/XAFSmass.git
#simpy run it via `python XAFSmassQt.py`

#######################
### OPTIONAL METHOD ###
#######################

#--------------------------
#Silx (http://www.silx.org)
#--------------------------
#REQUIREMENTS:
#- numpy   (=> conda)
#- h5py    (=> conda)
#- ipython (=> conda)
#- fisx    (=> pip)
#(using personal fork)
cd; cd $MYDEVEL
git clone https://github.com/maurov/silx.git
cd silx
git remote add --track master upstream https://github.com/silx-kit/silx.git
git fetch upstream
git merge upstream/master
python setup.py build --no-cython
SPECFILE_USE_GNU_SOURCE=1 python setup.py install
#build documentation
#python setup.py build_doc
#to run the tests: python -> import silx.test -> silx.test.run_tests()
cd; silx test --no-opengl --no-opencl

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
