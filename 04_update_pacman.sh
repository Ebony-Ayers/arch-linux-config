sed -i "s|#\[multilib\]|\[multilib\]|g" etc/pacman.conf
sed -i "s|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|g" etc/pacman.conf
pacman -Syyuu
pacman -S git nano
