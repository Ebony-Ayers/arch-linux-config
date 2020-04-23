#!/bin/sh

choice="Cancel\nPull\nPush"
chosen=$(echo -e "$choice" | dmenu -i -p "What do you want to do?")

case "$chosen" in
	"Pull") /personalisation/rclone/pull-school.sh ;;
	"Push") /personalisation/rclone/push-school.sh ;;
	*) ;;
esac
