source prompt.sh

promptConfirm "Enter the root partition"
rootPart=$promptResult
promptAnswersSingle "Root partition type" "ext4" "btrfs"
rootFS=$promptResult
promptYesNo "Do you want to format the root partition"
formatRoot=$promptResult

echo ""
promptYesNo "Do you want to enable swap"
swapOn=$promptResult
if [[ $swapOn = "y" ]]
then
	promptConfirm "Enter the swap partition"
	swapPart=$promptResult
fi

echo ""
promptConfirm "Enter the boot partition"
bootPart=$promptResult
promptYesNo "Do you want to format the boot partition"
formatBoot=$promptResult

echo ""

bash legacy/01_initial_commands.sh

if [[ $formatRoot = "y" ]]
then
	if [[ $rootFS = "ext4" ]]
	then
		bash legacy/02_ext4_create_root.sh $rootPart "format"
	else
		bash legacy/02_btrfs_create_root.sh $rootPart "format"
	fi
else
	if [[ $rootFS = "ext4" ]]
	then
		bash legacy/02_ext4_create_root.sh $rootPart
	else
		bash legacy/02_btrfs_create_root.sh $rootPart
	fi
fi

if [[ $swapOn = "y" ]]
then
	bash legacy/03_swap.sh $swapPart "format"
else
	bash legacy/03_swap.sh "off"
fi

if [[ $formatBoot = "y" ]]
then
	bash legacy/04_boot_partition.sh $bootPart "format"
else
	bash legacy/04_boot_partition.sh $bootPart
fi

echo "rootFS=\"$rootFS\"" >> variables.sh
echo "bootPart=\"$bootPart\"" >> variables.sh

bash legacy/05_pacstrap.sh

echo ""
echo ""
echo "Run the following commands:"
echo "arch-chroot /mnt"
echo "cd /install"
echo "bash stage_2.sh"
echo ""
