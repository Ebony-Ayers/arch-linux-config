#!/bin/sh

choice="Shutdown\nReboot\nSleep\nHybernate\nLock\nCancel"
chosen=$(echo -e "$choice" | dmenu -i -p "What do you want to do?")

case "$chosen" in
	"Shutdown") /personalisation/dmenu_scripts/shutdown.sh ;;
	"Reboot") /personalisation/dmenu_scripts/reboot.sh ;;
	"Sleep") /personalisation/dmenu_scripts/sleep.sh ;;
	"Hybernate") /personalisation/dmenu_scripts/hybernate.sh ;;
	"Lock") /personalisation/dmenu_scripts/lock.sh ;;
	*) ;;
esac
