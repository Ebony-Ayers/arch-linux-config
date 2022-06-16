if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

export EDITOR=nano
visudo
useradd -m $1
usermod -aG video,storage,optical,audio,wheel $1
echo "set password for $1"
passwd $1
echo "set password for root"
passwd
