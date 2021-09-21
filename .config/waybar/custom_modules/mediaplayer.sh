#!/bin/sh

pkill -9 playerctl

info() {
        if [ "$state" = "Playing" ]; then
                printf '{"text": "%s", "class": "custom-%s", "alt": "%s", "tooltip": "%s: %s\\nPlayer: %s"}\n' \
                        "$title" "$player" "$player" "$state" "$title" "$player"
        elif [ "$state" = "Paused" ] || [ "$state" = "Stopped" ]; then
                printf '{"text": " %s", "class": "custom-%s", "alt": "%s", "tooltip": "%s: %s\\nPlayer: %s"}\n' \
                        "$title" "$player" "$player" "$state" "$title" "$player"
        else
                echo
        fi
}

playerctl metadata -F -f '{{ playerName }} {{ status }} {{ title }}' |
        while read -r player state title; do
                info
        done
