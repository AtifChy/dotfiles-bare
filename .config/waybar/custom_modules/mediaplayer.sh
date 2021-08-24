#!/bin/sh

playerctl metadata -F -f '{{ playerName }} {{ status }} {{ title }}' |
        while read -r player state title; do
                if [ "$state" = "Playing" ]; then
                        echo "{\"text\": \"${title}\", \"class\": \"custom-${player}\", \"alt\": \"${player}\", \"tooltip\": \"${state}: ${title}\\\\nPlayer: ${player}\"}"
		elif [ "$state" = "Paused" ] || [ "$state" = "Stopped" ]; then
                        echo "{\"text\": \" ${title}\", \"class\": \"custom-${player}\", \"alt\": \"${player}\", \"tooltip\": \"${state}: ${title}\\\\nPlayer: ${player}\"}"
		else
			echo
                fi
        done
