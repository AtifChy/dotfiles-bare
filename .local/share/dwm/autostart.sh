#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run feh --bg-fill /home/atif/Pictures/wallpapers/future.jpg &
run redshift-gtk &
run nm-applet &
run picom --experimental-backends -b &
run dunst &
xrdb -merge ~/.config/X11/Xresources &
run clipmenud &
run dwmblocks 2>&1 >/dev/null &
run mpd &
