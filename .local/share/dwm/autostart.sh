#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run feh --bg-fill --no-fehbg /home/atif/Pictures/wallpapers/future.jpg &
run redshift-gtk &
run nm-applet &
run picom --experimental-backends -b &
run dunst &
xrdb -merge ~/.config/X11/Xresources &
run clipmenud &
run mpd &
run xautolock -locker slock &

# keep this below everything
run dwmblocks 2>&1 >/dev/null &
