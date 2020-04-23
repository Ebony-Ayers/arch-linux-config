#!/bin/sh

choice=""
chosen=$(echo -e "$choice" | dmenu -i -p "Volume=")

pacmd set-sink-volume 0 0x"$chosen"00
