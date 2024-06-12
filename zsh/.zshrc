export DEFAULT_USER="fernando"
export TERM="xterm-256color"
# export ZSH=/usr/share/oh-my-zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# zstyle :compinstall filename '/home/casey/.zshrc'

# autoload -Uz compinit

plugins=(git archlinux colorize) # zsh-syntax-highlighting)

# ZSH_THEME="agnoster"
# see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster

# source $ZSH/oh-my-zsh.sh

# User Configuration

alias c=clear
alias cat='bat --paging=never'
alias d='docker'
alias dc="docker-compose"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
xrandr --output HDMI-2 --primary --auto --output DVI-D-1 --left-of HDMI-2

if [ -e /home/casey/.nix-profile/etc/profile.d/nix.sh ]; then . /home/casey/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
