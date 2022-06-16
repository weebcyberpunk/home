#!/bin/sh

# author GG weebcyberpunk@gmail.com
# version 1.0.0
# since Apr 28, 2022

# allow to change the X keymap between the brazilian ABNT2 keymap and the
# international us keymap

ACTUAL_KEYMAP="$(setxkbmap -print -verbose 10 | grep layout | awk '{print substr($2, 0)}')"
if [ $ACTUAL_KEYMAP == "us" ]
then
	setxkbmap br abnt2 caps:swapescape
	notify-send 'Changed keymap' 'Keymap was changed to Brazilian ABNT2'
else
	setxkbmap us -option caps:swapescape -option compose:menu
	notify-send 'Changed keymap' 'Keymap was changed to American'
fi
