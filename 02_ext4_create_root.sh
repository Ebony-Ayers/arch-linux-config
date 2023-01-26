if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

if [ $# -gt 1 ]
then
	if [ $2 = "format" ]
	then
		mkfs.ext4 $1
	fi
fi

mount $1 /mnt
