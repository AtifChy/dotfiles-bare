#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run feh --bg-fill /home/atif/Pictures/wallpapers/wallpapers/Art/Other/73497750_p0.jpg &
run redshift-gtk &
run nm-applet &
run picom --experimental-backends -b &
run dunst &
run xrdb ~/.config/X11/Xresources &
run clipmenud &
run dwmblocks 2>&1 >/dev/null &
run mpd &
