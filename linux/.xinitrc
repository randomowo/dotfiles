#!/bin/bash

#amixer set Master mute # mute volume on startup
exec dwm
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
