mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
mv mirrorlist /etc/pacman.d/mirrorlist
echo "========================Set mirror list========================"
bash press_any_key_to_continue.sh



bash add_folders.sh
bash mount_drives.sh
read -p "Enter the mount point for root: " rootPartition
bash base_installer.sh $rootPartition
read -p "Do you want to manually edit fstab? [y/N]: " editFstb
if [ $editFstb = "y" ]
then
	nano $rootPartition/etc/fstab
elif [ $editFstb = "Y" ]
then
	nano $rootPartition/etc/fstab
fi
echo "========================Done base install========================"
bash press_any_key_to_continue.sh



arch-chroot $rootMountPoint
echo "========================Chrooted into new OS========================"
bash press_any_key_to_continue.sh



read -p "Enter time zone (/usr/share/zoneinfo/Region/City): " timeZone
bash set_time.sh $timeZone
echo "========================Set time zone========================"
bash press_any_key_to_continue.sh



bash set_locale.sh
echo "========================Set locale========================"
bash press_any_key_to_continue.sh



read -p "Enter desiered machine name: " machineName
bash set_machine_name.sh $mashineName
echo "========================Set machine name========================"
bash press_any_key_to_continue.sh



bash make_initial_ramdisk.sh
echo "========================Made initial ramdisk========================"
bash press_any_key_to_continue.sh



echo "Enter new root password"
passwd
echo "========================Updated root password========================"
bash press_any_key_to_continue.sh



read -p "Enter desiered user name: " userName
bash add_user.sh $userName
echo "========================Set user name========================"
bash press_any_key_to_continue.sh



bash edt_sudoers_file.sh
echo "========================Modified sudoers file========================"
bash press_any_key_to_continue.sh



read -p "Enter cpu vendor name (\"intel\" or \"amd\"): " cpuVendor
bash install_cpu_microcode.sh $cpuVendor
echo "========================Installed CPU microcode ========================"
bash press_any_key_to_continue.sh



sudo pacman -S grub efibootmgr os-prober
read -p "Enter efi partition: " efiPartition
read -p "Enter desiered efi partition mount point: " efiPartitionMountPoint
read -p "Do you want to mount extra partitions for discovery in grub? [y/N]: " otherOSPartitions
if [ $otherOSPartitions = "y" ]
then
	bash mount_drives.sh
elif [ $otherOSPartitions = "Y" ]
then
	bash mount_drives.sh
fi
mount $efiPartition $efiPartitionMountPoint
bash install_grub.sh $efiPartitionMountPoint
echo "========================Set installed grub========================"
bash press_any_key_to_continue.sh
