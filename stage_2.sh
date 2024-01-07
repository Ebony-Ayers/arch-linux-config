source prompt.sh
source variables.sh

promptConfirm "Enter the system time zone (leave blank for Melbourne)"
timeZone=$promptResult

echo ""
promptConfirm "Enter the machine name"
machineName=$promptResult

echo ""
promptAnswersSingle "Enter the cpu vendor" "amd" "intel"
cpuVendor=$promptResult

echo ""
promptConfirm "Enter new user name"
userName=$promptResult

echo ""
promptAnswersSingle "Enter gpu vendor" "amd" "nvidia" "intel"
gpuVendor=$promptResult
promptAnswersSingle "Enter desiered graphics server" "wayland" "xorg"
graphicsServer=$promptResult
promptAnswersSingle "Enter desiered desktop envrioment" "gnome" "kde" "none"
de=$promptResult

echo ""
promptAnswersMulti "Optional additional packages to install" "blender" "c++" "discord" "gimp" "gparted" "musescore" "python" "qemu" "qgis" "vs code"
additionalPackages=$promptResult

if [[ $bootFS = "ext4" ]]
then
	bash legacy/06_ext4_update_pacman.sh
else
	bash legacy/06_btrfs_update_pacman.sh
fi

bash legacy/07_setup_time.sh $timeZone
bash legacy/08_machine_name_and_network.sh $machineName
bash legacy/09_initial_ram_disk.sh $cpuVendor
bash legacy/10_grub.sh $bootPart
bash legacy/11_users.sh $userName

if [[ $de = "none" ]]
then
	bash legacy/12_graphics.sh "gpu=$gpuVendor" "server=$graphicsServer"
else
	bash legacy/12_graphics.sh "gpu=$gpuVendor" "server=$graphicsServer" "de=$de"
fi

additionalPackagesList=""
for arg in $additionalPackages; do
	if [[ $arg = "c++" ]]
	then
		bash legacy/install_c++.sh
	elif [[ $arg = "python" ]]
	then
		bash legacy/install_python.sh
	elif [[ $arg = "qemu" ]]
	then
		bash legacy/install_qemu.sh
	elif [[ $arg = "vs code" ]]
	then
		additionalPackagesList="code $additionalPackagesList"
	else
		additionalPackagesList="$arg $additionalPackagesList"
	fi
done
pacman -S $additionalPackagesList

echo ""
echo "Run the following commands:"
echo "exit"
echo "bash stage_3.sh"

