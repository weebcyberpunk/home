cd ~/Desktop # so all records go to ~/Desktop
TERM='st'
ACTIONS=("Record screen\nRecord cam\nRecord mic\nTake a shot\nRecord all")
CHOICE=$(echo -e $ACTIONS | dmenu)

if [ "$CHOICE" == 'Record screen' ]
then
	$TERM -e  ffmpeg -f x11grab -i :0.0 x11-screen-record.mp4 

elif [ "$CHOICE" == 'Record cam' ]
then
	$TERM -e  ffmpeg -i /dev/video0 -f alsa -i default webcam-record.mp4 

elif [ "$CHOICE" == 'Record mic' ]
then
	$TERM -e  ffmpeg -i /dev/video0 -f alsa -i default webcam-record.mp4 

elif [ "$CHOICE" == 'Take a shot' ]
then 
	$TERM -e  mpv av://v4l2:/dev/video0 --profile=low-latency --untimed 

elif [ "$CHOICE" == 'Record all' ]
then
	$TERM -e  $HOME/.local/bin/record-all.sh 

else
	exit
fi
