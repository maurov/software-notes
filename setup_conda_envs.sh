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
#to activate the `root` environment
source $MYLOCAL/conda/bin/activate

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
#The following are valid both `py36`, `py35` and `py27` conda environments
conda install numpy matplotlib ipython scipy pyzmq ipykernel jupyter h5py pandas sqlalchemy sphinx bottlechest pillow yaml termcolor requests nose

#cython may generate errors
#conda install cython 

#gcc from conda generates this error
# => libstdc++.so.6: version `CXXABI_1.3.9' not found
#conda install gcc

#pyopenGL (STILL WORK IN PROGRESS!!!)
#conda install pyopengl pyopengl-accelerate
#pyopenCL (NOT WORKING YET!)
#conda install -c conda-forge pyopencl

#UPDT: installing anaconda will create a BIG MESS!!! DO NOT DO IT!!!
#conda install anaconda

#/!\ spyder can MESS things with QT!!!
#conda install spyder

#py27-only
conda install wxpython

#packages installed from conda-forge channel


##############################
# PACKAGES INSTALLED VIA PIP #
##############################
#first activate one of the conda enviroment:
#source $MYLOCAL/conda/bin/activate py36
#source $MYLOCAL/conda/bin/activate py27

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


##################################
# PACKAGES INSTALLED FROM SOURCE #
##################################
#first activate one of the conda enviroment:
#source $MYLOCAL/conda/bin/activate py36
#source $MYLOCAL/conda/bin/activate py27

#-------------------------------------
#Fisx (https://github.com/vasole/fisx)
#-------------------------------------
cd; cd $MYLOCAL
git clone https://github.com/vasole/fisx
cd fisx
python setup.py install

#--------------------------
#Silx (http://www.silx.org)
#--------------------------
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
#sudo apt-get install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev
#make sure fisx is installed
#(using personal fork)
cd; cd $MYDEVEL
git clone https://github.com/maurov/pymca.git
cd pymca
git remote add --track master upstream https://github.com/vasole/pymca.git
git fetch upstream
git merge upstream/master
SPECFILE_USE_GNU_SOURCE=1 python setup.py install
#build documentation
python setup.py build_doc
#
#TOOLTIP COLOR FIX: the tooltips will appear black on black, this is
# fixed by using `gnome-color-chooser` to set the tooltip color to a
# readable one!

#-----------------------------------------
#LARCH (http://xraypy.github.io/xraylarch)
#-----------------------------------------
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


##################################
# OASYS IN A DEDICATED CONDA ENV #
##################################
#https://github.com/srio/oasys-installation-scripts/blob/master/install_oasys_using_miniconda.sh
#Conda dedicated environment
conda create --name py35qt4 python=3.5
source deactivate
source $MYLOCAL/conda/bin/activate py35qt4
conda install --yes pyqt=4 numpy scipy matplotlib=1.4.3 python-dateutil pytz pyparsing nose swig
#xraylib
curl -O http://lvserver.ugent.be/xraylib/xraylib-3.2.0.tar.gz
tar xvfz xraylib-3.2.0.tar.gz
cd xraylib-3.2.0
./configure --enable-python --enable-python-integration PYTHON=`which python`
make
export PYTHON_SITE_PACKAGES=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
#export PYTHON_SITE_PACKAGES=/home/mauro/local/conda/envs/py35qt4/lib/python3.5/site-packages/
cp python/.libs/_xraylib.so $PYTHON_SITE_PACKAGES
cp python/xrayhelp.py $PYTHON_SITE_PACKAGES
cp python/xraylib.py $PYTHON_SITE_PACKAGES
cp python/xraymessages.py $PYTHON_SITE_PACKAGES
cd ..
# srxraylib
git clone https://github.com/lucarebuffi/srxraylib
cd srxraylib
pip install -e . --no-binary :all:
cd ..
#shadow3
git clone https://github.com/srio/shadow3
cd shadow3
python setup.py build
pip install -e . --no-binary :all:
cd ..
# fisx
git clone https://github.com/vasole/fisx
cd fisx
python setup.py install
cd ..
#pymca
pip install PyMca5
# git clone https://github.com/vasole/pymca
# cd pymca
# python setup.py install
# cd ..
pip install oasys

#- start ShadowOui with this command:
#    source $MYLOCAL/conda/bin/activate py35qt4
#    python -m oasys.canvas -l4 --force-discovery
#- click on Add-Ons"
#- check next to ShadowOui (options: OASYS-XRayServer & OASYS-XOPPY)"
#- click OK button"
#- wait for installation"
#- restart oasys"

