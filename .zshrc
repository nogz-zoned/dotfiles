################################
# oh-my-zsh stuff              /
################################
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
plugins=(archlinux git colorize sudo tmux torrent vundle)

################################
# sources                      /
################################
#source $DOTFILES/export.zsh
#source $DOTFILES/aliases.zsh
source $ZSH/oh-my-zsh.sh
source $ANTIGEN/antigen.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

################################
# autocompletion               /
################################
autoload -U compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

################################
# other things                 /
################################
[ "$DISPLAY" ] && xset b 100
[[ $- != *i* ]] && return

################################
# functions                    /
################################
man() {
	local width=$(tput cols)
	[ $width -gt $MANWIDTH ] && width = $MANWIDTH
	env MANWIDTH=$width \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;40;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
	man "$@"
}

alias weec="screen weechat-curses"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
