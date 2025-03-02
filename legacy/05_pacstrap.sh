pacstrap -K /mnt base linux linux-firmware git
genfstab -U /mnt >> /mnt/etc/fstab

mkdir /mnt/install
cp -r ./* /mnt/install
