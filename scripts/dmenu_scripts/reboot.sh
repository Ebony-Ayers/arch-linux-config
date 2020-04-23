#!/bin/sh

choice="No\nYes"
chosen=$(echo -e "$choice" | dmenu -i -p "Do you want to reboot?")

case "$chosen" in
	"Yes") /personalisation/power_managment/reboot.sh ;;
	"No")  ;;
	*) ;;
esac
