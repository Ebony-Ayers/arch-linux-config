source prompt.sh
source variables.sh

#install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --save --answerdiff None --answerclean None --removemake

#optional spotify install
promptYesNo "Would you like to install spotify"
installSpotify=$promptResult
if [[ $installSpotify = "y" ]]
then
	yay -S spotify
fi

#configure git
git config --global push.default "current"
git config --global push.autoSetupRemote true
git config --global advice.addIgnoredFile false
git config --global init.defaultBranch "main"

#if qemu is installed add user to libvert group
if [[ $installedQemu -eq 1 ]]
then
	sudo usermod -aG libvirtd $userName
	
	#ask the user if they would like to install looking glass
	promptYesNo "Would you like to install Looking Glass"
	installLookingGlass=$promptResult
	if [[ $installLookingGlass = "y" ]]
	then
		yay -S looking-glass
	fi
fi

#install browser
promptAnswersMulti "What browser would you like to install" "Chrome" "Firefox" "None"
browser=$promptResult
if [[ $browser = "Chrome" ]]
then
	yay -S google-chrome
elif [[ $browser = "Firefox" ]]
then
	sudo pacman -S firefox --noconfirm
fi

#install gnome packages from the aur and remove bloat
if [[ $de = "gnome" ]]
then
	sudo pacman -Rsu gnome-contacts gnome-weather gnome-maps simple-scan gnome-tour gnome-font-viewer gnome-characters gnome-connections gnome-disk-utility yelp epiphany gnome-logs gnome-calendar gnome-clocks gnome-text-editor --noconfirm
	if [[ $installedVScode -eq 1 ]]
	then
		yay -S nautilus-code
	fi
	
	#ask the user if they wish to pre configure gnome
	promptYesNo "Would you like to install use Ebony's gnome configuration"
	configureGnome=$promptResult
	if [[ $configureGnome = "y" ]]
	then
		gsettings set org.gnome.desktop.interface enable-hot-corners false
		gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
		gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
		gsettings set org.gnome.desktop.interface clock-format "12h"
		gsettings set org.gnome.desktop.interface clock-show-seconds true
		gsettings set org.gtk.settings.file-chooser clock-format "12h"
		gsettings set org.gnome.desktop.peripherals.mouse accel-profile "flat"
		gsettings set org.gnome.desktop.peripherals.mouse speed -0.3
		gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
		gsettings set org.gnome.desktop.peripherals.touchpad click-method "areas"
		gsettings set org.gnome.desktop.peripherals.touchpad accel-profile "default"
		gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
		gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
		gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 6
		gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6
		gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4700
		gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
		gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
		gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
		gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
		gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
		gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "terminal"
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'kgx'
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Control><Alt>t"
		gsettings set org.gnome.calculator button-mode "advanced"
		gsettings set org.gnome.shell disabled-extensions "['apps-menu@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']"
		if [[ $browser = "Chrome" ]]
		then
			gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Console.desktop', 'org.gnome.Calculator.desktop']"
		elif [[ $browser = "Firefox" ]]
		then
			gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Console.desktop', 'org.gnome.Calculator.desktop']"
		else
			gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'org.gnome.Console.desktop', 'org.gnome.Calculator.desktop']"
		fi
	fi
fi

#configure vscode
if [[ $installedVScode -eq 1 ]]
then
	mkdir -p "~/.config/Code - OSS/User"
	
	if [[ $installedCpp -eq 1 ]]
	then
		cp vs_code_settings.json "~/.config/Code - OSS/User/settings.json"
	else
		cp vs_code_settings_no_cpp.json "~/.config/Code - OSS/User/settings.json"
	fi
	sudo chown $userName "~/.config/Code - OSS/User/settings.json"
fi

sudo rm post_install.sh
sudo rm variables.sh
sudo rm prompt.sh
sudo rm vs_code_settings.json
sudo rm vs_code_settings_no_cpp.json
