sed -i -z "s/\n/|/g" /etc/pacman.conf
sed -i "s+#\[multilib\]|#Include = /etc/pacman.d/mirrorlist+\[multilib\]|Include = /etc/pacman.d/mirrorlist+g" /etc/pacman.conf
sed -i -z "s/|/\n/g" /etc/pacman.conf
pacman -Syyuu
pacman -S nano dosfstools btrfs-progs base-devel alsa-utils alsa-firmware less --noconfirm
