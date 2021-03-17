#!/usr/bin/env fish

# ███████╗██╗░██████╗██╗░░██╗
# ██╔════╝██║██╔════╝██║░░██║
# █████╗░░██║╚█████╗░███████║
# ██╔══╝░░██║░╚═══██╗██╔══██║
# ██║░░░░░██║██████╔╝██║░░██║
# ╚═╝░░░░░╚═╝╚═════╝░╚═╝░░╚═╝

# Adds `~/.local/bin` to $PATH
set PATH $HOME/.local/bin $HOME/.local/bin/statusbar $PATH

# useful aliases
alias ls='ls --color=auto -lFh --group-directories-first --time-style long-iso'
alias l='ls --color=auto -lAFh --group-directories-first --time-style long-iso'
alias ll='ls --color=auto -laFh --group-directories-first --time-style long-iso'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias f='find . -name'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ip='ip -c'
alias pactree='pactree --color'
alias vdir='vdir --color=auto'
alias watch='watch --color'
alias sudo='sudo -sE'
alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'
alias dotfile='git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME' 	# github bare repo dotfile alias

# Abbreviations (expanded aliases)
abbr df 'df -h'
abbr du 'du -h'
abbr free 'free -h'
abbr x 'extract'
abbr tri 'trizen'
abbr triR 'trizen -Rnsuc'
abbr vi 'nvim'
abbr pik 'pikaur'
abbr pikR 'pikaur -Runsc'
abbr ff 'find / -name'
abbr f 'find . -name'
abbr clr 'clear'

# Follow XDG file directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority 		# This line will break some DMs.
#export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
#export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
#export KODI_DATA="$XDG_DATA_HOME/kodi"
#export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
#export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
#export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
#export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
#export UNISON="$XDG_DATA_HOME/unison"
#export HISTFILE="$XDG_DATA_HOME/history"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
#export LESSHISTFILE="-" 					# disable lesshistfile
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export ZDOTDIR=$HOME/.config/zsh
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# starship theme
#starship init fish | source
#export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# pfetch environment
#export PF_INFO="ascii title os host kernel uptime pkgs shell wm editor memory"
#export PF_SEP="=>"

# Clipmenu
#export CM_SELECTIONS="clipboard"
#export CM_DEBUG=0
#export CM_OUTPUT_CLIP=1
#export CM_MAX_CLIPS=30

# color for man pages
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

# Ibus KDE
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus

# start ibus-deamon on boot
#ibus-daemon -drx

# fix qt apps
#if [ $XDG_CURRENT_DESKTOP = "KDE" ]
#	dunstctl set-paused true
#else
#	export QT_QPA_PLATFORMTHEME='qt5ct'
#end
