while :
do
	PROCESS="$(pstree -lp | grep dwmstatus.sh | awk -F '---' '{print substr($2, 6)}' | sed -e 's/(//g' -e 's/)//g')"
	if [ -n $(echo $PROCESS | awk '$0 ~/[^0-9]/') ]
	then
		kill $PROCESS
		exit

	else
		continue
	fi
done