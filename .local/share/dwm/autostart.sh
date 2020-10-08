#!/bin/sh
feh --bg-fill ~/Pictures/wallpaperflare.com_wallpaper\ \(9\).jpg &
nm-applet --indicator &
killall redshift-gtk &
redshift-gtk &
#redshift-gtk -t 6500k:3800k &
picom --experimental-backends &
killall dunst &
dunst &
xrdb --merge ~/.Xresources &

# Statusbar loop
 while true; do
    xsetroot -name "$( date +"%a, %b %d, %Y %I:%M %p" )"
    sleep 1m    # Update time every minute
 done &
