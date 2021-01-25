#!/usr/bin/env bash

# for some reason gnome doesn't load ~/.zprofile
[[ -f ~/.zshenv ]] && source ~/.zshenv
[[ -f ~/.zprofile ]] && source ~/.zprofile
