pacstrap $1 base linux linux-firmware gcc git nano vim
genfstab -U $1 >> $1/etc/fstab
