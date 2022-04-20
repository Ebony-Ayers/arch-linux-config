ln -sf $1 /etc/localtime
hwclock --systohc
sed -i "s|#en_AU.UTF-8 UTF-8|en_AU.UTF-8 UTF-8|g" /etc/locale.gen
sed -i "s|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|g" /etc/locale.gen
locale-gen
echo "LANG=en_AU.UTF-8" >> /etc/locale.conf
