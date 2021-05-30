read -n1 -r -p "add \"nvme\" to modules. Press any key to continue..." key
nano /etc/mkinitcpio.conf
mkinitcpio -P
