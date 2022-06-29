#!/bin/sh -e

. ~/.local/lib/x

case "$(hostname)" in
	gijyutsu)
		#export GDK_DPI_SCALE=1.25
		#export QT_SCALE_FACTOR=1.25
		setdpi 96

		monitors | while read -r monitor; do
			# Used in clamshell exclusively.
			if [ "$monitor" = "HDMI1" ]; then
				monioff LVDS1
				break
			fi
		done
		unset monitor
		;;
	koneko)
		#export GDK_DPI_SCALE=1.25
		#export QT_SCALE_FACTOR=1.25
		setdpi 96
		;;
esac

xrdb -merge < "$HOME/.Xresources"

runsvdir ~/.local/var/sv &

setbg ~/.config/wall

if command -v ibus >/dev/null 2>&1; then
	export GTK_IM_MODULE=ibus
	export QT_IM_MODULE=ibus
	export XMODIFIERS=@im=ibus
fi

xset r rate 300 50 &

# I'd like to exec this but I need to cleanup runit before we leave.
gpg-agent --daemon -- dwm

usv force-stop ~/.local/var/sv/*
usv exit ~/.local/var/sv/*
