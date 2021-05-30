grub-install --target=x86_64-efi --efi-directory=$1 --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
