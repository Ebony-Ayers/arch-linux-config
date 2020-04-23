#!/bin/sh

choice="Cancel\nPull\nPush"
chosen=$(echo -e "$choice" | dmenu -i -p "What do you want to do?")

case "$chosen" in
	"Pull") /personalisation/rclone/pull-personal.sh ;;
	"Push") /personalisation/rclone/push-personal.sh ;;
	*) ;;
esac
