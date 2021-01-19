#!/usr/bin/env bash

# for some reason gnome doesn't load ~/.zprofile
[[ -f ~/.zshenv ]] && source ~/.zshenv
[[ -f ~/.config/zsh/.zprofile ]] && source ~/.config/zsh/.zprofile
