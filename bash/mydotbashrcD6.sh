# ---------------------------------------------------------------------- #
# Mauro Rovezzi's BASH config file <mauro.rovezzi@gmail.com>
# MIT License
# D6 version: optimized for Debian 6 (e.g. ESRF beamlines)
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# CUSTOM PART // CHANGE HERE
# ---------------------------------------------------------------------- #

#PROXY SETTINGS AT ESRF
export http_proxy=http://proxy.esrf.fr:3128/
export https_proxy=https://proxy.esrf.fr:3128/
export ftp_proxy=http://proxy.esrf.fr:3128/
export no_proxy="localhost,127.0.0.1"
export HTTP_PROXY=http://proxy.esrf.fr:3128/
export HTTPS_PROXY=https://proxy.esrf.fr:3128/
export FTP_PROXY=http://proxy.esrf.fr:3128/
export NO_PROXY="localhost,127.0.0.1"

#add .local/bin to PATH
export PATH=$HOME/.local/bin:$PATH

# ---------------------------------------------------------------------- #
# DEFAULT PART // TAKEN FROM SYSTEM .bashrc
# ---------------------------------------------------------------------- #

# User bash startup file
# (c) ESRF 1998 - 2012

# Maintained by TID/CS - call 2424 in case of trouble
# Written by E.Eyer + B.Rouselle, based on work by H.Witsch + S.Ohlsson

# Shell behavior for interactive shells (PS1 is predefined)
if [ -n "$PS1" ]; then
        # report background job completion immediately
        set notify=on
        # failed exec do not terminate the shell
        set no_exit_on_failed_exec
        # history control: store duplicate command once only
        HISTCONTROL=ignoredups
        # history control: store multiline commands in a single line
        set command_oriented_history
fi

# ESRF standard prompt
my_pwd () {
        loc=${PWD}/
        [[ $loc = ${HOME}/* ]] && loc=\~${loc#$HOME}
        [[ $loc = ?*/*/*/*/*/ ]] && loc=${loc#${loc%/*/*/*/}/}
        echo "${loc%/}"
}
_esrf_cd () {
        'cd' "$@" && PS1="\H:$(my_pwd) % "
}
alias cd=_esrf_cd
PS1="\H:$(my_pwd) % "

# Some ESRF standard aliases
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -la'
alias l='ls -l'
alias lt='ls -lrt'

# Feel free to add your own aliases (or environment variables)
# DO NOT invoke external commands from .bashrc! (performance)
