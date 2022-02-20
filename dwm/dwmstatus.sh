#!/usr/bin/sh

status () {

	# cmus widget
	echo -n "  "

	CMUS_ARTIST="$(cmus-remote -Q 2> /dev/null | grep ' artist ' | awk '{print substr($0, 12)}')"  
	CMUS_TRACK="$(cmus-remote -Q 2> /dev/null | grep ' title ' | awk '{print substr($0, 11)}')"

	if [ "$CMUS_ARTIST" = "" ]
	then
		echo -n "nothing playing"
	elif [ "$CMUS_ARTIST" = "Various" ]
	then
		echo -n "$CMUS_TRACK"
	else
		echo -n "$CMUS_ARTIST - $CMUS_TRACK"
	fi

	echo -n " | "

	# pamixer volume
	echo -n " "
	echo -n "$(pamixer --get-volume-human)"

	echo -n " | "

	# internet widget
	WLAN_STATUS=$(ip link | grep wlan0 | awk -F "," '{print $3}')
	ENP_STATUS=$(ip link | grep enp1s0 | awk '{print $9}')

	if [ "$WLAN_STATUS" = "UP" ]
	then
		echo -n "直 "
	elif [ "$ENP_STATUS" = "UP" ]
	then
		echo -n "爵 "
	else
		echo -n "睊 "
	fi

	echo -n " | "

	# battery widget and notify
	BATTERY=$(cat /sys/class/power_supply/BAT1/capacity)
	CHARGING=$(cat /sys/class/power_supply/BAT1/status)
	
	if [ $CHARGING == "Charging" ]
	then
		echo -n " $BATTERY%"

	else

		if [ $BATTERY -gt 80 ]
		then
			echo -n " $BATTERY%"

		elif [ $BATTERY -gt 60 ]
		then
			echo -n " $BATTERY%"

		elif [ $BATTERY -gt 40 ]
		then
			echo -n " $BATTERY%"

		elif [ $BATTERY -gt 20 ]
		then
			echo -n " $BATTERY%"

		elif [ $BATTERY -gt 10 ]
		then
			echo -n " $BATTERY%"

		else
			echo -n " $BATTERY%"
			
		fi

	fi

	echo -n " | "

	# date
	echo -n "$(date +'%b %d, %H:%M')"
}

while :
do
	xsetroot -name "$(status)"

	# sleep so it doesn't take all our resources
	sleep 1m
done
