export EDITOR=nano
visudo
useradd -m $1
usermod -aG -G video,storage,optical,audio,wheel $1
