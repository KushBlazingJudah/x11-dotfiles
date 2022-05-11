# See also:
#   - .config/aliases
#   - .config/functions
#   - .config/zsh/.zshrc

# Default applications
export BROWSER="firefox"
export TERMINAL="st"

# Set editor to nvim if it's there
if command -v nvim >/dev/null 2>&1; then
	export EDITOR="nvim"
else
	export EDITOR="vim"
fi

# Home directory cleanup
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

export GOPATH="${XDG_DATA_HOME}/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync"
export WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Add GOPATH bin into path if it exists
if [ -d "$GOPATH/bin" ]; then
	export PATH="$GOPATH/bin:$PATH"
fi

# Various settings
export LESS=-R
export LESSHISTFILE="-"
export LESSOPEN="| highlight -O ansi %s 2>/dev/null"
export LESS_TERMCAP_mb="$(printf '%b' '\033[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '\033[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '\033[0m')"
export LESS_TERMCAP_se="$(printf '%b' '\033[0m')"
export LESS_TERMCAP_so="$(printf '%b' '\033[01;44;33m')"
export LESS_TERMCAP_ue="$(printf '%b' '\033[0m')"
export LESS_TERMCAP_us="$(printf '%b' '\033[1;32m')"
# export WOBSOCK="${XDG_RUNTIME_DIR}/wob.sock"

# Disable Google's package proxy
export GOPROXY=direct
export GOSUMDB=off

# Fixups
# export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
# export QT_QPA_PLATFORM=wayland # needs qt5-wayland
export QT_QPA_PLATFORMTHEME="gtk2"
export _JAVA_AWT_WM_NONREPARENTING=1

if [ "$TERM" = "foot" ]; then
	export TERM="xterm-256color"
fi

# Change DPI based on hostname
case "$(hostname)" in
	koneko)
		export GDK_DPI_SCALE=1.25
		export QT_SCALE_FACTOR=1.25
		;;
esac

# IME
if command -v fcitx5 >/dev/null 2>&1; then
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	export SDL_IM_MODULE=fcitx
fi

# ~/.local/bin in PATH
export PATH="$HOME/.local/bin:$PATH"

# Autostart a GUI if on tty1
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	if command -v sway >/dev/null 2>&1; then
		exec sway
	elif command -v startx >/dev/null 2>&1; then
		exec startx
	fi
fi
