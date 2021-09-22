#!/bin/sh

pkill -9 playerctl

info() {
        if [ "$state" = "Playing" ]; then
                printf '{"text": "%s", "class": "custom-%s", "alt": "%s", "tooltip": "<b>%s:</b> %s\\n<b>Player:</b> %s"}\n' \
                        "$title" "$player" "$player" "$state" "$title" "$player"
        elif [ "$state" = "Paused" ] || [ "$state" = "Stopped" ]; then
                printf '{"text": " %s", "class": "custom-%s", "alt": "%s", "tooltip": "<b>%s:</b> %s\\nPlayer: %s"}\n' \
                        "$title" "$player" "$player" "$state" "$title" "$player"
        else
                echo
        fi
}

playerctl metadata -F -f '{{ playerName }} {{ status }} {{ trunc(title, 40) }}' |
        while read -r player state title; do
                info
        done
