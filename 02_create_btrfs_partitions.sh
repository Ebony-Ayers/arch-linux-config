mount $1 /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -t btrfs -o subvol=/@root $1 /mnt
mkdir /mnt/home
mkdir /mnt/.snapshots
mount -t btrfs -o subvol=/@home $1 /mnt/home
mount -t btrfs -o subvol=/@shapshots $1 /mnt/.snapshots
