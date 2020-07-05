#!/bin/bash
# by randomowo

export XCURSOR_SIZE=16

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_VIDEOS_DIR="$HOME/media/vid"
export XDG_PICTURES_DIR="$HOME/media/pic"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDF_RUNTIME_DIR="$PROGPATH/xdgruntime"

export MEDIAPATH="$XDG_DOCUMENTS_DIR/media"
export PROGPATH="$XDG_CONFIG_HOME/progs"
export SHOTPATH="$MEDIAPATH/pic/screenshots"
export RECPATH="$MEDIAPATH/vid/rec"
export UNI="$XDG_DOCUMENTS_DIR/university"

# ZSH
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

# DEFAULTS
export BROWSER="brave"
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"

export GOPATH="$PROGPATH/go"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GRADLE_USER_HOME="$PROGPATH/gradle"
export NCFTPDIR="$PROGPATH/ncftp"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export LESSHISTFILE="/dev/null"
export WINEPREFIX="$PROGPATH/wine"
export CARGO_HOME="$PROGPATH/cargo"
export VIMINIT="source $XDG_CONFIG_HOME/vim/.vimrc"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea.vmoptions"
export AUDACITY_PATH="$XDG_CONFIG_HOME/audacity-data"
export MEDNAFEN_HOME="$XDG_CONFIG_HOME/mednafen"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolki
# xorg
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# expand $PATH 
export PATH="$PATH:$ALTERA_ROOT/quartus/bin:$MATLAB_ROOT/bin:$GOPATH:/usr/bin:$HOME/.local/bin"

# colors
[ -f ~/.cache/wal/colors-tty.sh ] && source ~/.cache/wal/colors-tty.sh

#wmname compiz
#xss-lock -- /usr/local/bin/myi3lock &
