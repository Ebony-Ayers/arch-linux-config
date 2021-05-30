read -n1 -r -p "Uncomment desiered locales. Press any key to continue..." key
nano /etc/locale.gen
locale-gen
