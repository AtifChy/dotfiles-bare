
# ███████╗██████╗░██████╗░░█████╗░███████╗██╗██╗░░░░░███████╗
# ╚════██║██╔══██╗██╔══██╗██╔══██╗██╔════╝██║██║░░░░░██╔════╝
# ░░███╔═╝██████╔╝██████╔╝██║░░██║█████╗░░██║██║░░░░░█████╗░░
# ██╔══╝░░██╔═══╝░██╔══██╗██║░░██║██╔══╝░░██║██║░░░░░██╔══╝░░
# ███████╗██║░░░░░██║░░██║╚█████╔╝██║░░░░░██║███████╗███████╗
# ╚══════╝╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═╝╚══════╝╚══════╝

# some useful PATH
export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$HOME/.config/emacs/bin:$PATH"

# pfetch environment
export PF_INFO="ascii title os host kernel uptime pkgs shell wm editor memory"
export PF_SEP="=>"

# Apps
export TERMINAL='alacritty'
export BROWSER='brave'

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

# Ibus KDE
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus

# start ibus-deamon on boot
#ibus-daemon -drx

# qt apps theme
if [ "$XDG_CURRENT_DESKTOP" = "" ]; then
	export QT_QPA_PLATFORMTHEME='qt5ct'
fi

if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
	dunstctl set-paused true
fi
