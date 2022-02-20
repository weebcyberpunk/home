#!/usr/bin/sh

if [ "$1" == "--increase" ]
then
	pamixer -i 1

elif [ "$1" == "--decrease" ]
then
	pamixer -d 1

else
	pamixer -t

fi

$HOME/.local/bin/dwm_refresh_status.sh
