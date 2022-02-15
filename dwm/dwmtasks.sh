#!/usr/bin/sh

# author GG weebcyberpunk@gmail.com
# version 0.0.0
# since Feb 14, 2022

# tasks I want my computer to run every 30 minutes

function tasks() {

	notify-send "Checking for system upgrades" "Updating database with mirror"

	UPDATES=$(checkupdates | wc -l) 	# checkupdates is a script installed with pacman-contrib package

	if [ $UPDATES -eq 0 ]
	then
		notify-send "Your system is up to date"

	elif [ $UPDATES -eq 1 ]
	then
		notify-send "You have $UPDATES package to upgrade" "Perform full system upgrade with pacman -Syu"

	else
		notify-send "You have $UPDATES packages to upgrade" "Perform full system upgrade with pacman -Syu"
	fi

}

while :
do
	tasks
	sleep 30m
done
