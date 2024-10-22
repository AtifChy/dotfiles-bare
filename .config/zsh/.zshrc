# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
declare -A ZINIT
ZINIT[HOME_DIR]=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/zinit
ZINIT[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-$ZSH_VERSION

if [[ ! -f ${ZINIT[HOME_DIR]}/bin/zinit.zsh ]]; then
	print -P "%F{4}▓▒░ %F{3}Installing %F{4}DHARMA%F{3} Initiative Plugin Manager (%F{4}zdharma/zinit%F{3})…%f"
	mkdir -p "${ZINIT[HOME_DIR]}" && chmod g-rwX "${ZINIT[HOME_DIR]}"
	git clone https://github.com/zdharma/zinit "${ZINIT[HOME_DIR]}/bin" && {
		print -P "%F{4}▓▒░ %F{34}Installation successful.%f%b" ||
		print -P "%F{1}▓▒░ The clone has failed.%f%b"
	}
fi

source "${ZINIT[HOME_DIR]}/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

## zsh prompt
zinit lucid light-mode for \
	romkatv/powerlevel10k

# starship prompt config
#zinit lucid light-mode for \
#	as"command" from"gh-r" \
#	atload'eval "$(starship init zsh)"' \
#	bpick'*unknown-linux-gnu*' \
#		starship/starship

## zsh plugins
zinit wait lucid light-mode for \
    atinit"
		HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=8,fg=2,bold'
		HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=8,fg=9,bold'
	" \
    atload'
		bindkey "${key[Up]}"   history-substring-search-up
		bindkey "${key[Down]}" history-substring-search-down
	' \
		zsh-users/zsh-history-substring-search \
    atinit"
		typeset -gA FAST_HIGHLIGHT
		FAST_HIGHLIGHT[git-cmsg-len]=100
		ZINIT[COMPINIT_OPTS]=-C
		zicompinit
		zicdreplay
	" \
		zdharma/fast-syntax-highlighting \
        blockf atpull'zinit creinstall -q .' \
		zsh-users/zsh-completions \
    atinit"
		ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
		ZSH_AUTOSUGGEST_STRATEGY=(history completion)
		ZSH_AUTOSUGGEST_COMPLETION_IGNORE='_*|pre(cmd|exec)|sudo pacman -S*|pacman -S*|paru -S*|yay -S*|\)\*'
	" \
    atload"_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions \
    trigger-load'!x;!extract' \
		OMZP::extract

# Fallback zsh prompt
#PROMPT='%(?.%B%F{green}➜%f%b.%F{red}➜%f) '

## zsh tweaks
PROMPT_EOL_MARK='%B%F{8}↵%f%b'
SPROMPT='zsh: correct %B%F{red}%R%f%b to %B%F{green}%r%f%b [nyae]? '
function command_not_found_handler {
	print -P "zsh: command not found: %B%F{blue}$1%f%B"
}

## zsh settings
setopt auto_cd			# auto cd to given dir if cd command not used
#DIRSTACKSIZE=16		# cache how many dirs for pushd
#setopt auto_pushd		# go back to previously visited dirs (e.g. cd -<TAB>)
#setopt pushd_ignore_dups	# remove duplicates
#setopt pushd_minus		# last visited dir on top
setopt interactivecomments	# Ignore lines prefixed with '#'
setopt extended_history		# record timestamp of command in HISTFILE
setopt hist_expire_dups_first	# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups		# Don't record an entry that was just recorded again
setopt hist_find_no_dups	# Do not display a line previously found
setopt hist_ignore_space	# ignore commands that start with space
setopt hist_verify		# show command with history expansion to user before running it
setopt inc_append_history	# add commands to HISTFILE in order of execution
setopt share_history		# shell share history with other tabs
setopt always_to_end		# cursor moved to the end in full completion
setopt complete_in_word		# allow completion from within a word/phrase
setopt automenu			# show completion menu on a successive tab press
setopt nobeep			# disable beeping on tab completion
setopt noflowcontrol		# disable start/stop characters in shell editor
setopt correct			# spelling correction
#setopt globdots		# show files beginning with a `.`

# enable native autojump in zsh
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':chpwd:*' recent-dirs-max 50
zstyle ':chpwd:*' recent-dirs-file "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/chpwd-recent-dirs"
zstyle ':completion:*' recent-dirs-insert always
alias z=cdr

# zsh completion settings
eval "$(dircolors)"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-separator '=>'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%U%B%F{cyan}%d%f%b%u'
zstyle ':completion:*:warnings' format '%U%B%F{red}no match found%f%b%u'
zstyle ':completion:*' ignored-patterns '\[|~'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:(vim|nvim|vi|nano):*' ignored-patterns '*.(wav|mp3|flac|ogg|mp4|avi|mkv|iso|so|o|7z|zip|tar|gz|bz2|rar|deb|pkg|gzip|pdf|png|jpeg|jpg|gif)'
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}" "ma=38;5;7;7;1"
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#) ([0-9a-z-]#)*=36=0=01"
TRAPUSR1() { rehash }        # rehash after upgrade -- requires pacman hook

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
	title '%100>…>$CMD%<<'
}

add-zsh-hook precmd title_precmd
add-zsh-hook preexec title_preexec

# alias
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias.zsh"

# better url management
autoload -U bracketed-paste-magic url-quote-magic
zle -N bracketed-paste bracketed-paste-magic
zle -N self-insert url-quote-magic

## keybindings
typeset -g -A key

key[Home]='^[[H'
key[End]='^[[4~'
key[Insert]='^[[4h'
key[Backspace]='^?'
key[Delete]='^[[P'
key[Up]='^[[A'
key[Down]='^[[B'
key[Left]='^[[D'
key[Right]='^[[C'
key[PageUp]='^[[5~'
key[PageDown]='^[[6~'
key[Shift-Tab]='^[[Z'
key[Ctrl-Left]='^[[1;5D'
key[Ctrl-Right]='^[[1;5C'

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
bindkey "${key[Ctrl-Left]}"  backward-word
bindkey "${key[Ctrl-Right]}" forward-word

# being used by plugin:-zsh-history-substring-search
#bindkey "${key[Up]}"         history-beginning-search-backward
#bindkey "${key[Down]}"       history-beginning-search-forward

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
