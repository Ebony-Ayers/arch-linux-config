mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp mirrorlist /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware
