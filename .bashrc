#
# ~/.bashrc
#
# ██████╗░░█████╗░░██████╗██╗░░██╗██████╗░░█████╗░
# ██╔══██╗██╔══██╗██╔════╝██║░░██║██╔══██╗██╔══██╗
# ██████╦╝███████║╚█████╗░███████║██████╔╝██║░░╚═╝
# ██╔══██╗██╔══██║░╚═══██╗██╔══██║██╔══██╗██║░░██╗
# ██████╦╝██║░░██║██████╔╝██║░░██║██║░░██║╚█████╔╝
# ╚═════╝░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source /etc/profile

# github dotfile repo alias
alias dotfile='git --git-dir=$HOME/Documents/Dotfiles/ --work-tree=$HOME'


if [ "$XDG_CURRENT_DESKTOP" = "wayland" ]
then
	echo hi
else
	echo bye
fi
