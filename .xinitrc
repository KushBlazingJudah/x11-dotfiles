#!/bin/sh -e

. ~/.local/lib/x

case "$(hostname)" in
	gijyutsu)
		monitors | while read -r monitor; do
			if [ "$monitor" = "HDMI1" ]; then
				monioff LVDS1
				break
			fi
		done
		unset monitor
		;;
esac

xrdb -merge < "$HOME/.Xresources"

picom &
xset r rate 300 50 &
unclutter-xfixes &

exec dwm
