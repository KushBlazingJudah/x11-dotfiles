#!/bin/sh -e

. ~/.local/lib/x

case "$(hostname)" in
	gijyutsu)
		monitors | while read -r monitor; do
			# Used in clamshell exclusively.
			if [ "$monitor" = "HDMI1" ]; then
				monioff LVDS1
				break
			fi
		done
		unset monitor
		;;
esac

xrdb -merge < "$HOME/.Xresources"
setbg ~/.config/wall

if command -v ibus >/dev/null 2>&1; then
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
	ibus-daemon -rxR &
fi

picom &
xset r rate 300 50 &
unclutter-xfixes &
dwmblock &

exec dwm
