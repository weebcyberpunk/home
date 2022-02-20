#!/usr/bin/sh

cd ~/Music
ALBUM="$(stat */* --format "%n" | awk -F '/' '{print substr($2, 0)}' | dmenu)"

if [ "$ALBUM" != "" ]
then
	nohup $HOME/.local/bin/cmus_open.sh &

	while :
	do
		if [ "$(pstree | grep '\-\-\-cmus\-\-\-')" != "" ]
		then
			cmus-remote -C 'view 2'
			cmus-remote -C "/$ALBUM"
			cmus-remote -C 'win-activate'
			cmus-remote -C 'view 1'
			cmus-remote -C 'win-sel-cur'
			exit
		else
			continue
		fi
	done
fi
