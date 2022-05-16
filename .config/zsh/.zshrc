# Use machine name in PS1 if over SSH
if [ -n "$SSH_CONNECTION" ]; then
	export PS1="%m%(?..!%?)%(1j.&%j.)%# "
else
	export PS1="%(?..!%?)%(1j.&%j.)%# "
fi

# Explaination of PS1 since I don't understand it myself:
# %m: hostname
# %(?..!%?): display !exit_code if exit code is nonzero
# %(1j.&%j.): display &jobs if there are any jobs
# %#: % or # based on user
#
# The exclusion of a RPS1 was done on purpose, to make copypasting things
# easier.

# Move history file and make it smaller
export HISTFILE=~/.cache/zsh-histfile
export HISTSIZE=1000
export SAVEHIST=1000

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)

setopt autocd
stty stop undef	# disable ^s to freeze
bindkey -v # Vim keybindings

# Change cursor shape for different vi modes.
# stolen from luke's voidrice and modified
function zle-keymap-select () {
	case $KEYMAP in
		vicmd) printf '%b' '\033[2 q';;      # block
		viins|main) printf '%b' '\033[6 q';; # beam
	esac
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	printf '%b' '\033[6 q'
}
zle -N zle-line-init
printf '%b' '\033[6 q' # Use beam shape cursor on startup.
preexec() { printf '%b' '\033[6 q' ;} # Use beam shape cursor for each new prompt.

# Zinit setup
declare -A ZINIT
export ZINIT[BIN_DIR]="$HOME/.local/share/zinit/bin"
export ZINIT[HOME_DIR]="$HOME/.local/share/zinit"

# Zinit auto install
if [ ! -d "${ZINIT[BIN_DIR]}" ]; then
	echo "Installing zinit..."

	if ! command -v git >/dev/null 2>&1; then
		echo "Please install git!"
		exit
	fi

	mkdir -pv "${ZINIT[BIN_DIR]}"
	git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT[BIN_DIR]}"
	source "${ZINIT[BIN_DIR]}/zinit.zsh"

	# Self-compile
	zinit self-update
else
	source "${ZINIT[BIN_DIR]}/zinit.zsh"
fi

compinit

zinit ice depth=1

zinit wait lucid for \
	zdharma-continuum/fast-syntax-highlighting \
	zsh-users/zsh-completions

source "${XDG_CONFIG_HOME}/aliases"
source "${XDG_CONFIG_HOME}/functions"
