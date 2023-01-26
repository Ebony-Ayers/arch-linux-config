if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

if [ $# -gt 1 ]
then
	if [ $2 = "format" ]
	then
		mkfs.fat -F 32 $1
	fi
fi

mount --mkdir $1 /mnt/boot
