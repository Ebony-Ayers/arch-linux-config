mkinitcpio -P
if [ $1 = "amd" ]
then
	pacman -S amd-ucode --noconfirm
else
	pacman -S intel-ucode --noconfirm
fi
