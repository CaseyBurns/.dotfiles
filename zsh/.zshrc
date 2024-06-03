export DEFAULT_USER="fernando"
export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# zstyle :compinstall filename '/home/casey/.zshrc'

# autoload -Uz compinit

plugins=(git archlinux colorize) # zsh-syntax-highlighting)

ZSH_THEME="agnoster"
# see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster

source $ZSH/oh-my-zsh.sh

# User Configuration

alias c=clear
alias cat='bat --paging=never'

