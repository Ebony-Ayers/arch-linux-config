pacman -S qemu-full virt-manager ebtables dnsmasq edk2-ovmf swtpm --noconfirm
systemctl enable libvirtd
systemctl enable dnsmasq
virsh net-autostart default
