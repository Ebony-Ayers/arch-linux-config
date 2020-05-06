sudo pacman -S cups
sudo systemctl start org.cups.cupsd.service
sudo systemctl enable org.cups.cupsd.service
sudo pacman -S avahi
sudo pacman -S nss-mdns
sudo systemctl start avahi-daemon.service
sudo systemctl enable avahi-daemon.service
lpadmin -p WF-4740 -E -v "lpd://192.168.0.9:515/PASSTHRU" -m everywhere
