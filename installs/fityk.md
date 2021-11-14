
# Fityk

## Binary

[Fityk](http://www.unipress.waw.pl/fityk/) is a great software for peak-fitting. In Debian-based distributions it is available as a normal package. This is fine for normal usage GUI and CLI:

    sudo apt-get install fityk
 
## Source

In order to use Fityk functions in Python, building fro, the source code is needed First of all, read the INSTALL file provided in the distribution.

### Status

* [2021-11-14] rovezzi@slurm-nice-devel2903 *FAILED!*


### Common requirements

On my Ubuntu machine, I have installed the following packages.

  sudo apt-get install libboost-math-dev libwxbase2.8-dev libwxgtk2.8-dev wx2.8-headers wx-common python-dev libssl-dev python-sphinx swig autoconf autoconf2.13 autoconf-archive libreadline-dev

* Requirements listed
  * Boost::Math C++ library required
         $ sudo apt-get install libboost-math-dev
  * Wx
         $ sudo apt-get install libwxbase2.8-dev libwxgtk2.8-dev wx2.8-headers wx-common
  * Python.h
         $ sudo apt-get install python-dev
  * LibSSL
         $ sudo apt-get install libssl-dev
  * Sphinx
         $ sudo apt-get install python-sphinx
  * Swig
         $ sudo apt-get install swig
  * Requirements for autogen:
         $ sudo apt-get install autoconf autoconf2.13 autoconf-archive gnu-standards autoconf-doc libtool
  * Libreadline
         $ sudo apt-get install libreadline-dev

### Build xylib

* Check previous [common requirements]

* Clone the GIT repository

      git clone https://github.com/wojdyr/xylib.git
      cd xylib

* Create configure script

      autoreconf -iv
  
* Run configure

        export DOTLOCAL=/home/esrf/rovezzi/.local
        ./configure --prefix=$DOTLOCAL
 
 * Make and Install
 
        make clean
        make
        make install
 
* Link created library (add to `.bashrc`)

        export LD_LIBRARY_PATH=$DOTLOCAL:$LD_LIBRARY_PATH

### Build fityk from source

* Check previous [common requirements]

* Clone the GIT repository and go to the created directory (if you are doing an update, just run git pull in fityk directory, instead of the following)

      git clone git@github.com:wojdyr/fityk.git
      cd fityk
      
* Generate the .configure
 
      autoreconf -iv

* Configure

        export DOTLOCAL=/home/esrf/rovezzi/.local
        ./configure --prefix=$DOTLOCAL --enable-python
      
* Make & Install

        make clean
        make
        make install
        
* Link created library (add to `.bashrc`)

        export LD_LIBRARY_PATH=$DOTLOCAL:$LD_LIBRARY_PATH


## Custom FAQ

### Saving user defined functions

    On Tue, Oct 5, 2010 at 17:21, Soren <soreneus...@gmail.com> wrote:
    > Is there a way to save a user defined function from one session to
    the
    > next?
    yes, add it to the init file. Either use Session > Edit Init File or
    edit $HOME/.fityk/init (on MS Windows XP: C:\Documents and
    Settings\USERNAME\.fityk\init)
