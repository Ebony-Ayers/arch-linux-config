if [ $# -eq 0 ]
then
  echo "Error: no partition supplied"
  exit
fi

if [ $# -gt 1 ]
then
	if [ $2 = "format" ]
	then
		mkfs.btrfs $1
	fi
fi
 
mount $1 /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -t btrfs -o subvol=/@root $1 /mnt
mkdir /mnt/home
mkdir /mnt/.snapshots
mount -t btrfs -o subvol=/@home $1 /mnt/home
mount -t btrfs -o subvol=/@snapshots $1 /mnt/.snapshots
