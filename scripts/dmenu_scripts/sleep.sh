#!/bin/sh

choice="No\nYes"
chosen=$(echo -e "$choice" | dmenu -i -p "Do you want to sleep?")

case "$chosen" in
	"Yes") /personalisation/power_managment/sleep.sh ;;
	"No")  ;;
	*) ;;
esac
