packages=""
hasgraphicsServer=false
hasWayland=false
hasXorg=false
hasGPUDriver=false
hasNvidia=false
displayManager=""

for arg in "$@"
do
	#graphics servers
	if [ $arg = "server=wayland" ]
	then
		packages="$packages wayland"
		hasgraphicsServer=true
		hasWayland=true
	fi
	if [ $arg = "server=xorg" ]
	then
		packages="$packages xorg"
		hasgraphicsServer=true
		hasXorg=true
	fi
	
	#gpu drivers
	if [ $arg = "gpu=amd" ]
	then
		packages="$packages mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau"
		if [ "$hasXorg" = true ]
		then
			packages="$packages xf86-video-amdgpu"
		fi
		hasGPUDriver=true
	fi
	if [ $arg = "gpu=intel" ]
	then
		packages="$packages mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver"
		if [ "$hasXorg" = true ]
		then
			packages="$packages xf86-video-intel"
		fi
		hasGPUDriver=true
	fi
	if [ $arg = "gpu=nvidia" ]
	then
		packages="$packages nvidia nvidia-utils lib32-nvidia"
		hasGPUDriver=true
		hasNvidia=true
	fi
	
	#desktop enviroments
	if [ $arg = "de=gnome" ]
	then
		packages="$packages gnome gedit gnome-sound-recorder gnome-shell-extensions gnome-tweaks dconf-editor gparted gedit-plugins gnome-browser-connector espeakup"
		displayManager="gdm"
	fi
	if [ $arg = "de=kde" ]
	then
		packages="$packages plasma kde-applications sddm sddm-kcm"
		displayManager="sddm"
		if [ "$hasWayland" = true ]
		then
			packages="$packages plasma-wayland-session"
			if [ "$hasNvidia" = true ]
			then
				packages="$packages egl-wayland"
			fi
		fi
	fi
done

if [ "$hasgraphicsServer" = false ]
then
	echo "Error: must provide a graphics server with \"server=wayland\" or \"server=xorg\""
	exit
fi
if [ "$hasGPUDriver" = false ]
then
	echo "Error: must provide a gpu with \"gpu=amd\", \"gpu=intel\", or \"gpu=nvidia\""
	exit
fi

pacman -S $packages --noconfirm
systemctl enable $displayManager
