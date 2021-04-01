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
    command mkdir -p "$HOME/.cache/zinit" && command chmod g-rwX "$HOME/.cache/zinit"
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

# zsh plugins
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# ohmyzsh library, plugins, themes
zinit snippet OMZL::termsupport.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZP::extract

# more zsh plugins
#zinit ice wait lucid; zinit light olets/zsh-abbr
#zinit light MichaelAquilina/zsh-you-should-use

# zsh theme/s
zinit ice depth=1; zinit light romkatv/powerlevel10k

# zsh tweak
PROMPT_EOL_MARK='⏎'

# History file configuration
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history ]]; then
	command touch ${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history
fi
[ -z "$HISTFILE" ] && HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## zsh autocompletion
autoload -Uz compinit && compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' rehash true
#zstyle ':completion:*:descriptions' format '%U%B%F{cyan}%d%f%u'
export LS_COLORS="di=1;34"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump

# zsh autosuggestions strategy. options: history, completion
ZSH_AUTOSUGGEST_STRATEGY=(history)

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history 	      # shell share history with other tabs

# alias
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias.zsh

# fix url issue
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# source default configs
source /etc/profile

# some useful PATH
#export PATH="$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
