source prompt.sh
source variables.sh

#install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

#optional spotify install
function promptYesNo "Would you like to install spotify"
installSpotify=$promptResult
if [[ installSpotify = "y" ]]
then
	yay -S spotify
fi

#configure git
git config --global push.default = "current"
git config --global push.autoSetupRemote = true
git config --global advice.addIgnoredFile = false

#if qemu is installed add user to libvert group
if [[ $installedQemu -eq 1 ]]
then
	sudo usermod -aG libvirtd $userName
	
	#ask the user if they would like to install looking glass
	function promptYesNo "Would you like to install Looking Glass"
	installLookingGlass=$promptResult
	if [[ installLookingGlass = "y" ]]
	then
		yay -S looking-glass
	fi
fi

#install gnome packages from the aur and remove bloat
if [[ $de = "gnome" ]]
then
	yay -S gedit-plugins
	sudo pacman -Rsu gnome-contacts gnome-weather gnome-maps simple-scan gnome-tour gnome-font-viewer gnome-characters gnome-connections gnome-disk-utility yelp file-roller seahorse geary epiphany gnome-logs gnome-calendar gnome-clocks --noconfirm
	if [[ $installedVScode -eq 1 ]]
	then
		yay -S nautilus-code
	fi
	
	#ask the user if they wish to pre configure gnome
	function promptYesNo "Would you like to install use Ebony's gnome configuration"
	configureGnome=$promptResult
	if [[ configureGnome = "y" ]]
	then
		gsettings set org.gnome.shell.app-switcher current-workspace-only true
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
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 name "terminal"
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 binding "<Control><Alt>t"
		gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 command "kgx"
		gsettings set org.gnome.calculator button-mode "advanced"
		gsettings set org.gnome.shell disabled-extensions "['apps-menu@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']"
		gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'org.gnome.Console.desktop', 'org.gnome.Calculator.desktop']"
	fi
fi

#configure vscode
if [[ $installedVScode -eq 1 ]]
then
	mkdir -p ~/.config/Code/User
	if [[ $installedCpp -eq 1 ]]
	then
		#c++ extensions
		code --install-extension ms-vscode.cpptools
		code --install-extension twxs.cmake
		code --install-extension ms-vscode.cmake-tools
		code --install-extension ms-vscode.makefile-tools
		
		cp vs_code_settings.json ~/.config/Code/User/settings.json
	else
		cp vs_code_settings_no_cpp.json ~/.config/Code/User/settings.json
	fi
	sudo chown $userName ~/.config/Code/User/settings.json
	
	#python extension
	if [[ $installedPython -eq 1 ]]
	then
		code --install-extension ms-python.python
	fi
fi

sudo rm post_install.sh
sudo rm variables.sh
sudo rm prompt.sh
sudo rm vs_code_settings.json
sudo rm vs_code_settings_no_cpp.json
