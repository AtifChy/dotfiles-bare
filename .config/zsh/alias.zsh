## Modified commands
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias ip='ip -c'
alias pactree='pactree --color'
alias watch='watch --color'
alias free='free -h'
alias diff='diff --color=always'

## New commands
alias da='date "+%A, %B %d, %Y [%r]"'
alias du1='du --max-depth=1'
alias hist='history -200 | grep' # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep' # requires an argument

# Paru
#alias paruR='paru -Rnsuc'

# Privileged access
if ((UID != 0)); then
	alias sudo='sudo '
	alias scat='sudo cat'
	alias sv='sudoedit'
	alias root='sudo -i'
fi

# neovim
alias v='nvim'

## ls
#alias ls='exa --group --icons -hF'
alias ls='ls -hF --color=always'
alias l='ls -lA --group-directories-first --time-style="+%d-%m-%Y %I:%M%p"'
alias ll='ls -la --group-directories-first --time-style="+%d-%m-%Y %I:%M%p"'
alias lr='ls -R' # recursive ls
alias la='ll -A'
alias lx='ll -BX' # sort by extension
alias lz='ll -rS' # sort by size
alias lt='ll -rt' # sort by date
#alias lm='la | more'

## cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

## find
alias ff='find / -name'
alias f='find . -name'

## grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## Safety features
alias cp='cp -v'
alias mv='mv -v'
#alias rm='rm -v'
# safer alternative w/ timeout, not stored in history
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
#alias cls=' echo -ne "\033c"'       	# clear screen for real (it does not work in Terminology)

## Make Bash error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'

## update-grub
#alias update-grub='grub-mkconfig -o /boot/grub/grub.cfg'

## youtube-dl
alias yta-mp3='youtube-dl -f bestaudio --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --xattrs'
alias yta-m4a='youtube-dl -f bestaudio --extract-audio --audio-format m4a --embed-thumbnail --add-metadata --xattrs --postprocessor-args "-metadata album=YouTube -metadata comment=YOUTUBE"'

# alias for for github dotfile repo
alias dotfile='git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME'

# alias for reflector
alias reflector5='sudo reflector --verbose --latest 100 -n 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias reflectorbd='sudo reflector -c Bangladesh --save /etc/pacman.d/mirrorlist'
