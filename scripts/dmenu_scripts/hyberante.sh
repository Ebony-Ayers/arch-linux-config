#!/bin/sh

choice="No\nYes"
chosen=$(echo -e "$choice" | dmenu -i -p "Do you want to hybernate?")

case "$chosen" in
	"Yes") /personalisation/power_managment/hybernate.sh ;;
	"No")  ;;
	*) ;;
esac
