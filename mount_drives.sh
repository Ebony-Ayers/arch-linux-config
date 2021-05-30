while true
do
	read -p "Enter partition to be mounted: " userInputPartition
	read -p "Enter desiered mount point: " userInputMounPoint
	read -p "Enter mount options (leave blank for none): " userInputMountOptions
	read -p "Make new folder for mount point [y/N]: " userInputMakeNewFolder
	
	if [ $userInputMakeNewFolder = "y" ]
	then
		mkdir $userInputMounPoint
	elif [ $userInputMakeNewFolder = "Y" ]
	then
		mkdir $userInputMounPoint
	fi
	
	if [ $userInputMountOptions = "" ]
	then
		mount $userInputPartition $userInputMounPoint
	else
		mount -o $userInputMountOptions $userInputPartition $userInputMounPoint
	fi
	echo "Mounted $userInputPartition at $userInputMounPoint with options \"$userInputMountOptions\""
	
	read -p "What do you want to do next quit (q), mount another partition (p): " usrInputNextAction
	if [ $usrInputNextAction != "p" ]
	then
		break
	fi
done
