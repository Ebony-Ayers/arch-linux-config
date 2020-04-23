#!/bin/sh

choice="Set\nMute\nUnmute"
chosen=$(echo -e "$choice" | dmenu -i -p "What do you want to do?")

case "$chosen" in
	"Set") /personalisation/dmenu_scripts/set_volume.sh ;;
	"Mute") pacmd set-sink-mute 0 1 ;;
	"Unute") pacmd set-sink-mute 0 0 ;;
	*) ;;
esac
