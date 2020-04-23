#!/bin/sh

choice="Personal\nSchool"
chosen=$(echo -e "$choice" | dmenu -i -p "What do you want to do?")

case "$chosen" in
	"Personal") /personalisation/dmenu_scripts/google-drive-personal.sh ;;
	"School") /personalisation/dmenu_scripts/google-drive-school.sh ;;
	*) ;;
esac
