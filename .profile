#!/usr/bin/env sh

# custom PATH
export PATH="$HOME/.local/bin:$HOME/.config/emacs/bin:$HOME/.local/share/npm/bin:$PATH"

# pfetch environment
export PF_INFO='ascii title os kernel uptime pkgs shell wm editor memory'
export PF_SEP=' '

# Apps
export EDITOR='nvim'

# Firefox hardware video acceleration
[ "$XDG_SESSION_TYPE" = "wayland" ] && export MOZ_ENABLE_WAYLAND=1
[ "$XDG_SESSION_TYPE" = "x11" ] && export MOZ_X11_EGL=1
export MOZ_WEBRENDER=1

# Follow XDG file directory
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority # This line will break some DMs.
#export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch-config
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export WGETRC="$XDG_CONFIG_HOME"/wgetrc
alias wget='wget --hsts-file="$XDG_CACHE_HOME"/wget-hsts'
export INPUTRC="$XDG_CONFIG_HOME"/inputrc
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
#export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
#export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
#export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
#export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
#export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
#export UNISON="$XDG_DATA_HOME/unison"
#export HISTFILE="$XDG_DATA_HOME/history"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME"/yarn/config'
#export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
#export LESSHISTFILE="$XDG_CACHE_HOME"/lesshst
export LESSHISTFILE=- # disable lesshistfile
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export ATOM_HOME="$XDG_DATA_HOME"/atom
export SSB_HOME="$XDG_DATA_HOME"/zoom
export STACK_ROOT="$XDG_DATA_HOME"/stack
#export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
#export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
#export XMONAD_CONFIG_HOME="$XDG_CONFIG_HOME"/xmonad
#export XMONAD_DATA_HOME="$XDG_DATA_HOME"/xmonad
#export XMONAD_CACHE_HOME="$XDG_CACHE_HOME"/xmonad
[ -d ~/.ssr ] && mv ~/.ssr "$XDG_CONFIG_HOME"/simplescreenrecorder

# Ibus KDE
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# qt apps theme
[ -n "$(command -v qt5ct)" ] && export QT_QPA_PLATFORMTHEME='qt5ct'

# color less
LESS_TERMCAP_md=$(printf '\033[01;31m')
LESS_TERMCAP_me=$(printf '\033[0m')
LESS_TERMCAP_so=$(printf '\033[01;44;33m')
LESS_TERMCAP_se=$(printf '\033[0m')
LESS_TERMCAP_us=$(printf '\033[01;32m')
LESS_TERMCAP_ue=$(printf '\033[0m')
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_so
export LESS_TERMCAP_se
export LESS_TERMCAP_us
export LESS_TERMCAP_ue

# icons for lf file manager
[ -f "$XDG_CONFIG_HOME"/lf/scripts/icons.sh ] && . "$XDG_CONFIG_HOME"/lf/scripts/icons.sh

#[ "$DESKTOP_SESSION" != "xmonad" ] && dunstctl set-paused true

# startx
#alias startx='startx $XINITRC'
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        exec startx >"$XDG_CACHE_HOME"/x11/xsession-errors 2>&1
fi
