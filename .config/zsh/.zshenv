# custom path
typeset -U PATH path
path=("$HOME/.local/bin" "$HOME/.config/emacs/bin" "$path[@]")
export PATH
