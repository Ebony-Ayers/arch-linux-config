sed -i -z "s/\n/|/g" ~/pacman.conf
sed -i "s+#\[multilib\]|#Include = /etc/pacman.d/mirrorlist+\[multilib\]|Include = /etc/pacman.d/mirrorlist+g" ~/pacman.conf
sed -i -z "s/|/\n/g" ~/pacman.conf
pacman -Syyuu
pacman -S git nano
