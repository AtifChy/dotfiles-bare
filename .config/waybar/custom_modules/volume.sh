#!/bin/sh

increase() {
    current=$(
        pactl get-sink-volume @DEFAULT_SINK@ |
            while read -r _ _ _ _ volume _; do
                echo "$volume"
            done | tr -d '%\n'
    )
    if [ "$current" -lt '200' ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +"$*"%
    fi
}

decrease() {
    pactl set-sink-volume @DEFAULT_SINK@ -"$*"%
}

case $1 in
    up) increase "${2:-1}" ;;
    down) decrease "${2:-1}" ;;
esac
