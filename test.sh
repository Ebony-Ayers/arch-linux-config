if [ $# -gt 0 ]
then
	if [ $1 = "format" ]
	then
		echo "pacman -S amd-ucode"
	fi
fi
