pacstrap /mnt base linux linux-firmware git
genfstab -U /mnt >> /mnt/etc/fstab

mkdir /mnt/install
cp ./* /mnt/install
echo "\n Read \"instructions.txt\" or \"README.md\" for further instructions on chroot"
