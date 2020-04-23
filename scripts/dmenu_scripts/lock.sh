#!/bin/sh

choice="No\nYes"
chosen=$(echo -e "$choice" | dmenu -i -p "Do you want to lock?")

case "$chosen" in
	"Yes") /personalisation/power_managment/lock.sh ;;
	"No")  ;;
	*) ;;
esac
