#!/bin/sh

choice="No\nYes"
chosen=$(echo -e "$choice" | dmenu -i -p "Do you want to shutdown?")

case "$chosen" in
	"Yes") /personalisation/power_managment/shutdown.sh ;;
	"No")  ;;
	*) ;;
esac
