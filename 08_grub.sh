pacman -S grub efibootmgr
mount $1 /mnt
grub-install --target=x86_64-efi --efi-directory=/mnt --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
umount /mnt
