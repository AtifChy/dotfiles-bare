#!/usr/bin/env bash
function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run feh --bg-fill /home/atif/Pictures/wallpapers/wallpapers/Art/Other/73497750_p0.jpg &
run redshift-gtk &
#run redshift-gtk -t 6500k:3800k &
run nm-applet &
run picom --experimental-backends &
run dunst &
run xrdb ~/.config/X11/Xresources &
run clipmenud &
run dwmblocks 2>&1 >/dev/null &
run mpd &

## Statusbar loop
#while true; do
#    xsetroot -name "$( date +"%a, %b %d, %Y %I:%M %p" )"
#    sleep 1m    # Update time every minute
#done &
