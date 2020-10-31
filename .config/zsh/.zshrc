
# ███████╗░██████╗██╗░░██╗██████╗░░█████╗░
# ╚════██║██╔════╝██║░░██║██╔══██╗██╔══██╗
# ░░███╔═╝╚█████╗░███████║██████╔╝██║░░╚═╝
# ██╔══╝░░░╚═══██╗██╔══██║██╔══██╗██║░░██╗
# ███████╗██████╔╝██║░░██║██║░░██║╚█████╔╝
# ╚══════╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░

# Enable blur for unsupported terminals on X11 (Only works on KDE plasma)
#if [[ $(ps --no-header -p $PPID -o comm) =~ '^st|alacritty|kitty$' ]]; then
#        for wid in $(xdotool search --pid $PPID); do
#            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
#fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
declare -A ZINIT					# necessary for changing location
ZINIT[HOME_DIR]=$HOME/.cache/zinit

if [[ ! -f $HOME/.cache/zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.cache/zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.cache/zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.cache/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
#zinit light-mode for \
#    zinit-zsh/z-a-rust \
#    zinit-zsh/z-a-as-monitor \
#    zinit-zsh/z-a-patch-dl \
#    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# ohmyzsh library
#zinit snippet OMZL::history.zsh
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZL::key-bindings.zsh

# History
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$XDG_DATA_HOME/zsh/history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# Clean HOME_DIR
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# ohmyzsh plugin/s
zinit snippet OMZP::extract

# zsh plugins
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# zsh theme/s
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light olets/zsh-abbr

alias sudo='sudo -E'
alias clr='clear'
alias vi='nvim'
alias zinit='zinit -h'

source /etc/profile

# some useful PATH
#export PATH="$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH"

# alias for for github dotfile repo
alias dotfile='git --git-dir=$HOME/Documents/Dotfiles/ --work-tree=$HOME'

# alias for reflector
alias reflector5='sudo reflector --verbose --latest 100 -n 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# fix url issue
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# alias for ncmpcpp
alias music="ncmpcpp"
