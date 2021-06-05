#!/usr/bin/env bash

read -r -p "Do you wish to run this script? [y/n] " input
case $input in
[Yy][Ee][Ss] | [Yy])
        echo '\033[1;33mCONTINUE...\033[0m'
        continue
        ;;
[Nn][Oo] | [Nn]) exit ;;
*) echo "Please answer yes or no." ;;
esac

## enable ssh
if [[ ! -d ~/.ssh ]]; then
        read -r -p "Github email address? [e.g. user@email.com] " email
        echo -e '\033[1;31mWARNING:\033[0m use default location for credentials'
        ssh-keygen -t ed25519 -C "$email"
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
        echo -e '\n\033[1;31mWARNING:\033[0m add the following line to your github.\n'

        cat ~/.ssh/id_ed25519.pub

        echo -e '\n'
        read -p "Press \033[1;34m'ENTER'\033[0m if you are done"

        # cloning dotfile repo
        git clone --bare git@github.com:AtifChy/dotfiles.git $HOME/.config/dotfiles
        alias dotfile='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'

        # choose git branch
        printf 'Do you wish to change git branch?\n'
        printf '\n\033[1;30mCurrently active:\033[0m [* indicates active branch]\n'
        dotfile branch
        printf '\n'
        select yn in "master" "gnome"; do
                case $yn in
                master) BRANCH=master ;;
                gnome) BRANCH=gnome ;;
                xmonad) BRANCH=xmonad ;;
                esac
        done
        dotfile switch $BRANCH

        # disabled for unnesessary files
        dotfile config --local status.showUntrackedFiles no
        touch $HOME/.config/dotfiles/info/sparse-checkout
        echo '/*\n!README.md' >>$HOME/.config/dotfiles/info/sparse-checkout

        # Replace existing files with the files from repo
        dotfile checkout -f

        echo -e '\n\n===>\033[1;32mDONE\033[0m<===\n'
else
        echo 'No further configuration is required for SSH'
fi

## creating necessary folders and files
mkdir -pv $HOME/.local/share/{gnupg,cargo,go,vscode,rustup,pass}
mkdir -pv $HOME/.config/{less,parallel,npm,yarn}
mkdir -pv $HOME/.cache/{less,pylint,x11}
touch $HOME/.config/{wgetrc,inputrc,npm/npmrc}
printf hsts-file \= $HOME/.cache/wget-hsts >>"$HOME/.config/wgetrc"
printf 'prefix=${XDG_DATA_HOME}/npm\ncache=${XDG_CACHE_HOME}/npm\ntmp=${XDG_RUNTIME_DIR}/npm\ninit-module=${XDG_CONFIG_HOME}/npm/config/npm-init.js' >>$HOME/.config/npm/npmrc

## reboot
read -r -p "Do you wish to reboot? [y/n] " REB
case $REB in
[Yy][Ee][Ss] | [Yy]) reboot ;;
[Nn][Oo] | [Nn]) exit ;;
*) echo "Please answer yes or no." ;;
esac
