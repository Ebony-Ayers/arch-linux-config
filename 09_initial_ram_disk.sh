mkinitcpio -P
if [ $1 = "amd" ]
then
	pacman -S amd-ucode
else
	pacman -S intel-ucode
fi
