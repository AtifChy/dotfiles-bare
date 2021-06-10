### Added by Zinit's installer
declare -A ZINIT
ZINIT[HOME_DIR]=${XDG_CACHE_HOME:-$HOME/.cache}/zinit
ZINIT[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache-$ZSH_VERSION

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
### End of Zinit's installer chunk

## zsh prompt
zinit lucid for \
  as"command" from"gh-r" \
  atinit'
        export N_PREFIX="$HOME/n";
        [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
  ' \
  atload'eval "$(starship init zsh)"' \
  bpick'*unknown-linux-gnu*' \
  starship/starship

## zsh plugins
zinit wait lucid light-mode for \
  atload'
        bindkey "$terminfo[kcuu1]" history-substring-search-up;
        bindkey "$terminfo[kcud1]" history-substring-search-down
  ' \
      zsh-users/zsh-history-substring-search \
  atinit"
        typeset -gA FAST_HIGHLIGHT;
        FAST_HIGHLIGHT[git-cmsg-len]=100;
	zicompinit;
	zicdreplay
  " \
      zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
  atinit"
	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
	zstyle ':completion:*' completer _expand _complete _ignored _approximate
	zstyle ':completion:*' menu select=2
	zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache
	zstyle ':completion::complete:*' use-cache on
	zstyle ':completion:*:descriptions' format '%U%B%F{cyan}%d%f%u'
	TRAPUSR1() { rehash }        # /bin recache after update -- requires pacman hook
  " \
  atload'
        eval "$(dircolors)"
        zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" "ma=07;1"
  ' \
      zsh-users/zsh-completions \
  atinit"
        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20;
        ZSH_AUTOSUGGEST_STRATEGY=(history)
  " \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  trigger-load'!x' \
      OMZP::extract \
      OMZL::key-bindings.zsh

## zsh tweak
PROMPT_EOL_MARK='⏎'

## zsh settings
setopt auto_cd                # auto cd to given dir if cd command not used
DIRSTACKSIZE=16               # cache how many dirs for pushd
setopt auto_pushd             # go back to previously visited dirs (e.g. cd -<TAB>)
setopt pushd_ignore_dups      # remove duplicates
setopt interactivecomments    # Ignore lines prefixed with '#'
setopt pushd_minus            # last visited dir on top
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history 	      # shell share history with other tabs
setopt noflowcontrol
setopt always_to_end          # cursor moved to the end in full completion
setopt complete_in_word       # allow completion from within a word/phrase
setopt automenu
setopt nobeep                 # disable beeping on tab completion

## zsh autocompletion
# Already enabled by zinit. Don't enable them. TEST RUN : `time zsh -i -c exit`
#autoload -Uz compinit
#compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# zsh autosuggestions strategy. options: history, completion
#ZSH_AUTOSUGGEST_HISTORY_IGNORE="pacman -S*|paru -S*|git *"

# History file configuration
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history ]]; then
	command touch ${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history
fi
[ -z "$HISTFILE" ] && HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## terminal title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- "\e]2;${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|st*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# alias
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias.zsh

# fix url issue
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# source default configs
#source /etc/profile

# icons for lf file manager
[ -f ~/.config/lf/scripts/icons.sh ] && source ~/.config/lf/scripts/icons.sh
