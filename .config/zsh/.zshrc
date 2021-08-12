### Added by Zinit's installer
declare -A ZINIT
ZINIT[HOME_DIR]=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zinit
ZINIT[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-$ZSH_VERSION

if [[ ! -f $ZINIT[HOME_DIR]/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT[HOME_DIR]" && command chmod g-rwX "$ZINIT[HOME_DIR]"
    command git clone https://github.com/zdharma/zinit "$ZINIT[HOME_DIR]/bin" &&
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" ||
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINIT[HOME_DIR]/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

## zsh plugins
zinit wait lucid light-mode for \
  atinit"
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=black,bold';
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
  " \
  atload'
    bindkey "$terminfo[kcuu1]" history-substring-search-up;
    bindkey "$terminfo[kcud1]" history-substring-search-down
  ' \
  ver'dont-overwrite-config' \
      ericbn/zsh-history-substring-search \
  atinit"
    typeset -gA FAST_HIGHLIGHT;
    FAST_HIGHLIGHT[git-cmsg-len]=100;
    ZINIT[COMPINIT_OPTS]=-C;
    zicompinit;
    zicdreplay
  " \
      zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
  atinit"
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' completer _expand _complete _ignored _approximate
    zstyle ':completion:*' menu select=2
    zstyle ':completion:*:default' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*:descriptions' format '%U%B%F{cyan}%d%f%u'
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' ignored-patterns '\['
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
    zstyle ':completion:*:(vim|nvim|vi|nano):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif)'
    zstyle ':completion:*' insert-tab false
    TRAPUSR1() { rehash }        # rehash after upgrade -- requires pacman hook
  " \
  atload'
    eval "$(dircolors)"
    zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" "ma=07;1"
    zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#) ([0-9a-z-]#)*=36=0=01"
  ' \
      zsh-users/zsh-completions \
  atinit"
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20;
    ZSH_AUTOSUGGEST_STRATEGY=(history completion);
    ZSH_AUTOSUGGEST_COMPLETION_IGNORE='_*|pre(cmd|exec)|sudo pacman*|pacman*|paru*|yay*|\)\*|;*'
  " \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  trigger-load'!x' \
      OMZP::extract

## zsh prompt
if [ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/starship.zsh ]; then
        source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/starship.zsh
else
        starship init zsh --print-full-init >${XDG_CONFIG_HOME:-$HOME/.config}/zsh/starship.zsh
        source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/starship.zsh
fi

## zsh tweak
PROMPT_EOL_MARK='↵'

## zsh settings
setopt auto_cd                # auto cd to given dir if cd command not used
DIRSTACKSIZE=16               # cache how many dirs for pushd
setopt auto_pushd             # go back to previously visited dirs (e.g. cd -<TAB>)
setopt pushd_ignore_dups      # remove duplicates
setopt pushd_minus            # last visited dir on top
setopt interactivecomments    # Ignore lines prefixed with '#'
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # Don't record an entry that was just recorded again
setopt hist_find_no_dups      # Do not display a line previously found
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # shell share history with other tabs
setopt always_to_end          # cursor moved to the end in full completion
setopt complete_in_word       # allow completion from within a word/phrase
setopt automenu               # show completion menu on a successive tab press
setopt nobeep                 # disable beeping on tab completion
setopt noflowcontrol          # disable start/stop characters in shell editor
setopt correct                # spelling correction
#setopt globdots               # show files beginning with a `.`

# History file configuration
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## terminal title
function title {
  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${1:q}\a"
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\"
      ;;
  esac
}

function title_precmd {
  title "%n@%m:%~"
}

function title_preexec {
  local CMD="${1:gs/%/%%}"
  title '%100>...>$CMD%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd title_precmd
add-zsh-hook preexec title_preexec

# alias
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias.zsh

# better url management
autoload -Uz bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

## keybindings
# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
bindkey "${key[Home]}"       beginning-of-line
bindkey "${key[End]}"        end-of-line
bindkey "${key[Insert]}"     overwrite-mode
bindkey "${key[Backspace]}"  backward-delete-char
bindkey "${key[Delete]}"     delete-char
bindkey "${key[Left]}"       backward-char
bindkey "${key[Right]}"      forward-char
bindkey "${key[PageUp]}"     beginning-of-buffer-or-history
bindkey "${key[PageDown]}"   end-of-buffer-or-history
bindkey "${key[Shift-Tab]}"  reverse-menu-complete

# being used by plugin:-zsh-history-substring-search
#bindkey "${key[Up]}"         history-beginning-search-backward
#bindkey "${key[Down]}"       history-beginning-search-forward
