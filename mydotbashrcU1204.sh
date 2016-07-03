# ---------------------------------------------------------------------- #
# Mauro Rovezzi's BASH config file <mauro.rovezzi@gmail.com>
# MIT License
# Current version: optimized for XUbuntu 12.04
# ~/.bashrc -> ~/utils/software-notes/mydotbashrcU1204
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# default stuff
# ---------------------------------------------------------------------- #

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ---------------------------------------------------------------------- #
# GLOBAL VARIABLES
# ---------------------------------------------------------------------- #
# my local dir && utils
export MYLOCAL=$HOME/local
export PYTHONPATH=$HOME/utils:$PYTHONPATH

# Local PERL installation
#eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

#PYQUANTE CONF
export PYTHONPATH=$HOME/local/pyquante_lib:$PYTHONPATH

#TDL CONF (see software_install.org)
# Load RVM into a shell session *as a function*
#not need[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Added by CCP4 package manager:
if [ -f ~/local/ccp4/ccp4-6.4.0/bin/ccp4.setup-sh ]; then
    source /home/mauro/local/ccp4/ccp4-6.4.0/bin/ccp4.setup-sh
fi

# ATLAS/BLAS director
export ATLAS=/usr/lib/atlas-base/atlas
export BLAS=/usr/lib/openblas-base

# XOP/SHADOW3
export XOP_HOME=$MYLOCAL/xop2.3
export SHADOW3_HOME=$MYLOCAL/xop_extensions/shadowvui/shadow3
export LD_LIBRARY_PATH=$SHADOW3_HOME:$LD_LIBRARY_PATH

# not good idea, conficts with python 3.x -> use virtualenv!
#export SHADOW3_BUILD=$SHADOW3_HOME/build/lib.linux-x86_64-2.7
#export PYTHONPATH=$SHADOW3_BUILD:$PYTHONPATH

export DIFFPAT_EXEC=$MYLOCAL/CRYSTAL/diff_pat

# SLOTH
export SLOTHOME=$HOME/utils/xraysloth/sloth
export PYTHONPATH=$SLOTHOME:$PYTHONPATH
alias sloth='python $SLOTHOME/sloth_gui.py'
#alias sloth3='source $MYLOCAL/py3env/bin/activate; python $SLOTHOME/sloth_gui.py' #ipy 0.13 no RichIpythonWidget
alias ipylarch='python $SLOTHOME/ipylarch.py'

#add .local/bin to PATH
export PATH=$HOME/.local/bin:$PATH

#if you are behind a proxy
# export http_proxy=http://myproxy.server.com:8080/
# export https_proxy=http://myproxy.server.com:8080/
# export ftp_proxy=http://myproxy.server.com:8080/
# export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
# export HTTP_PROXY=http://myproxy.server.com:8080/
# export HTTPS_PROXY=http://myproxy.server.com:8080/
# export FTP_PROXY=http://myproxy.server.com:8080/
# export NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"