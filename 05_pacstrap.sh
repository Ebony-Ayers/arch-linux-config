pacstrap /mnt base linux linux-firmware git
genfstab -U /mnt >> /mnt/etc/fstab
