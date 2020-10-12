#!/usr/bin/env bash
function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run feh --bg-fill ~/Pictures/wallpapers/wall.png &
run redshift-gtk &
#redshift-gtk -t 6500k:3800k &
run nm-applet &
run picom --experimental-backends -b &
run dunst &
run xrdb ~/.Xresources &
run clipmenud &
run dwmblocks &

## Statusbar loop
#while true; do
#    xsetroot -name "$( date +"%a, %b %d, %Y %I:%M %p" )"
#    sleep 1m    # Update time every minute
#done &
