echo $1 >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	$1.localdomain $1" >> etc/hosts
pacman -S networkmanager
systemctl enable NetworkManager.service
