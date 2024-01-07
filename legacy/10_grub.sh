if [ $# -eq 0 ]
then
  echo "Error: no grub partition supplied"
  exit
fi

pacman -S grub efibootmgr --noconfirm
mount $1 /mnt
grub-install --target=x86_64-efi --efi-directory=/mnt --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
umount /mnt
