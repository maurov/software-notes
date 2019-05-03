# ---------------------------------------------------------------------- #
# Mauro Rovezzi's BASH config file <mauro.rovezzi@gmail.com>
# MIT License
# Current version: optimized for ubox1804 (XUbuntu 18.04, VirtuaBox guest in Windows 10)
# NOTE: make the following link
# ~/.bashrc -> ~/utils/software-notes/mydotbashrcUM1604
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# CUSTOM PART // CHANGE HERE
# ---------------------------------------------------------------------- #
# my local dir && utils
export MYLOCAL=$HOME/local
export MYDEVEL=$HOME/devel

#PROXY SETTINGS AT ESRF
#export http_proxy=http://proxy.esrf.fr:3128/
#export https_proxy=https://proxy.esrf.fr:3128/
#export ftp_proxy=http://proxy.esrf.fr:3128/
#export no_proxy="localhost,127.0.0.1,.esrf.fr"
#export HTTP_PROXY=http://proxy.esrf.fr:3128/
#export HTTPS_PROXY=https://proxy.esrf.fr:3128/
#export FTP_PROXY=http://proxy.esrf.fr:3128/
#export NO_PROXY="localhost,127.0.0.1,.esrf.fr"

#add .local/bin to PATH
#export PATH=$HOME/.local/bin:$PATH

#CRYSTAL
#export DIFFPAT_EXEC=$MYLOCAL/CRYSTAL/diff_pat

### ALIASES ###
#Conda envs
alias conda-base='unset PYTHONPATH; source $MYLOCAL/conda/bin/activate'
alias sloth-env='unset PYTHONPATH; source $MYLOCAL/conda/bin/activate sloth-env'
alias sloth-dev='unset PYTHONPATH; source $MYLOCAL/conda/bin/activate sloth-dev'

alias sloth='sloth-env; python -m sloth.gui.daxs.application -k'

#pymca within Conda env
#DO NOT USE FOLLOWING ALIAS, JUST ACTIVATE CONDA AND RUN `pymca`
#alias pymca='source $MYLOCAL/conda/bin/activate py35; python -m PyMca5.PyMcaGui.pymca.PyMcaMain'

#oasys within Conda env
#first manually activate the conda environment
alias oasys='python -m oasys.canvas -l4 --force-discovery'
