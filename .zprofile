#!/bin/bash
# by randomowo

export XCURSOR_SIZE=16

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export PROGPATH="$HOME/progs"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_VIDEOS_DIR="$HOME/media/vid"
export XDG_PICTURES_DIR="$HOME/media/pic"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDF_RUNTIME_DIR="$PROGPATH/xdgruntime"

# ZSH
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump"

# DEFAULTS
export BROWSER="brave"
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"

# go
export GOPATH="$PROGPATH/go"
# gradle
export GRADLE_USER_HOME="$PROGPATH/gradle"
# ncftp
export NCFTPDIR="$PROGPATH/ncftp"
# weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
# less
export LESSHISTFILE="/dev/null"
# wine
export WINEPREFIX="$PROGPATH/wine"
# cargo
export CARGO_HOME="$PROGPATH/cargo"
# vim
export VIMINIT="source $XDG_CONFIG_HOME/vim/.vimrc"
# python etc.
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
# IDEA
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea.vmoptions"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolki
# xorg
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# HOME PATHS
export UNI="$XDG_DOCUMENTS_DIR/university"

# expand $PATH 
export PATH="$PATH:$ALTERA_ROOT/quartus/bin:$MATLAB_ROOT/bin:$GOPATH:/usr/bin:$HOME/.local/bin"

#wmname compiz
xss-lock -- /usr/local/bin/myi3lock &
