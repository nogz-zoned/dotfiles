#-------------------------------
# export                       /
#-------------------------------

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export PATH=$PATH:~/bin
export TERM="xterm-256color"
export EDITOR=vim
export VISUAL=vim
export BROWSER=chromium
export ARCHFLAGS="-arch x86_64"
#export DOTFILES=/home/nogz/dotfiles
export ANTIGEN=~/.antigen
export TZ=America/New_York
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#-------------------------------
# sources                      /
#-------------------------------

#source $DOTFILES/aliases.zsh
source $ANTIGEN/antigen.zsh

#-------------------------------
# autocompletion               /
#-------------------------------

autoload -U compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

#-------------------------------
# other things                 /
#-------------------------------

#[ "$DISPLAY" ] && xset b 100
#[[ $- != *i* ]] && return
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

#-------------------------------
# antigen                      /
#-------------------------------

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	robbyrussell/oh-my-zsh plugins/archlinux
	robbyrussell/oh-my-zsh plugins/git
	robbyrussell/oh-my-zsh plugins/colorize
	robbyrussell/oh-my-zsh plugins/sudo
	robbyrussell/oh-my-zsh plugins/vundle
	robbyrussell/oh-my-zsh plugins/command-not-found
	robbyrussell/oh-my-zsh plugins/colored-man-pages
	robbyrussell/oh-my-zsh plugins/autojump
	zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme agnoster 
#antigen theme https://gist.github.com/3712874.git agnoster

antigen apply

#-------------------------------
# functions                    /
#-------------------------------

#-------------------------------
# aliases                      /
#-------------------------------

alias weec="screen weechat-curses"
