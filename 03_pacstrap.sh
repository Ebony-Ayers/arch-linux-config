pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
cd /mnt/tmp
git clone https://github.com/Ebony-Ayers/arch-linux-config
