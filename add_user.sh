useradd -m $1
passwd $1
usermod -aG wheel,audio,video,optical,storage $1
