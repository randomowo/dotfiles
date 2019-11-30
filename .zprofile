#!/bin/bash
# by randomowo

export PROGPATH="$HOME/progs"
export CONFPATH="$HOME/.config"

# ZSH
export ZSH="$HOME/.config/zsh/oh-my-zsh"
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump"

# DEFAULTS
export BROWSER="qutebrowser"
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"

# PATHS FOR SOME PROGRAMS
# altera quartus
export ALTERA_ROOT="/opt/altera/13.1"
export QUARTUS_ROOTDIR_OVERRIDE="$ALTERA_ROOT/quartus"
export QSYS_ROOTDIR="$QUARTUS_ROOTDIR_OVERRIDE/sopc_builder/bin"
export QUARTUS_LIBRARY_PATHS="$QUARTUS_ROOTDIR_OVERRIDE/linux/:/lib/x86_64-linux-gnu/"
export SOPC_KIT_NIOS2="$ALTERA_ROOT/nios2eds"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$QUARTUS_LIBRARY_PATHS"
# matlab
export MATLAB_ROOT="/opt/MATLAB/R2019b"
export MATLAB_PREFDIR="$CONFPATH/.matlab"
# go
export GOPATH="$PROGPATH/go"
# gradle
export GRADLE_USER_HOME="$PROGPATH/gradle"
# ncftp
export NCFTPDIR="$PROGPATH/ncftp"
# weechat
export WEECHAT_HOME="$CONFPATH/weechat"
# less
export LESSHISTFILE="/dev/null"
# wine
export WINEPREFIX="$PROGPATH/wine"
# vim
export VIMINIT="source $HOME/.config/vim/.vimrc"

# HOME PATHS
export UNI="$HOME/Documents/university"

# expand $PATH 
export PATH="$PATH:$ALTERA_ROOT/quartus/bin:$MATLAB_ROOT/bin:$GOPATH"

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolki
wmname compiz

startx
