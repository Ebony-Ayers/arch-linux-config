if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

if [ $1 = "off" ]
then
	swapoff
else
	if [ $# -gt 1 ]
	then
		if [ $2 = "format" ]
		then
			mkswap $1
		fi
	fi
	swapon $1
fi
