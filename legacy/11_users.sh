if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

export EDITOR=nano
read -p "You need to manually uncomment the line \"wheel      ALL=(ALL:ALL) ALL\". Press enter to continue." temp
visudo
useradd -m $1
usermod -aG video,storage,optical,audio,wheel $1
echo "set password for $1 (this is the user account, root password is next)"
passwd $1
echo "set password for root"
passwd
