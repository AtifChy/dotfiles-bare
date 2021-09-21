#!/bin/sh
refresh() {
        for _ in 1 2 3 4 5; do
                if ping -q -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
                        weather="$(curl -s https://wttr.in/?format=%x+%t)" && break
                else
                        sleep 2s
                fi
        done

        [ -z "$weather" ] && return

        condition=${weather% *}
        temperature=${weather##* }
        temperature=${weather##*+}

        if [ "${weather%;*}" = "Unknown location" ]; then
                unset condition
                unset temperature
                condition="Invaild"
                temperature="$condition"
        fi

        hour=$(date +%H)
        night_yet() {
                [ "$hour" -ge 19 ] && icon=$*
                [ "$hour" -le 4 ] && icon=$*
        }

        case $condition in
                "?") icon="" ;;
                "mm") icon="" ;;
                "=")
                        icon=""
                        night_yet ""
                        ;;
                "///") icon="" ;;
                "//") icon="" ;;
                "**") icon="" ;;
                "*/*") icon="" ;;
                "/")
                        icon=""
                        night_yet ""
                        ;;
                ".")
                        icon=""
                        night_yet ""
                        ;;
                "x")
                        icon=""
                        night_yet ""
                        ;;
                "x/")
                        icon=""
                        night_yet ""
                        ;;
                "*")
                        icon=""
                        night_yet ""
                        ;;
                "*/")
                        icon=""
                        night_yet ""
                        ;;
                "m")
                        icon=""
                        night_yet ""
                        ;;
                "o")
                        icon=""
                        night_yet ""
                        ;;
                "/!/") icon="" ;;
                "!/") icon="" ;;
                "*!*")
                        icon=""
                        night_yet ""
                        ;;
                "mmm") icon="" ;;
                "Invaild") icon="" ;;
        esac
}

xmobar() {
        set -f
        set -- $(xrdb -q | grep -E '*.color0:|*.color3:|*.color7:' | cut -f2 | tr '\n' ' ')
        set +f

        background=${1}:5
        yellow=$2
        white=$3

        refresh
        if [ -z "$weather" ]; then
                echo ' Offline'
        else
                printf '<fc=%s,%s>%s</fc><fc=%s,%s> %s</fc>\n' \
                        "$yellow" "$background" "$icon" "$white" "$background" "$temperature"
        fi
}

waybar() {
        refresh
        if [ -z "$weather" ]; then
                echo '{"text": " Offline", "tooltip": "Network connection unavailable."}'
        else
                tooltip="$(curl -s https://wttr.in/?format=\<b\>Condition:\</b\>+%C-\<b\>Temperature:\</b\>+%t\(%f\)-\<b\>Wind:\</b\>+%w | sed -e 's/-/\\n/g' -e 's/+//g')"
                printf '{"text": "%s %s", "tooltip": "%s"}\n' "$icon" "$temperature" "$tooltip"
        fi

}

case $1 in
        xmobar) xmobar ;;
        waybar) waybar ;;
        *)
                refresh
                if [ -z "$weather" ]; then
                        printf '\033[01;31mERROR:\033[0m Check your network connection.\n'
                else
                        printf '%s  %s\n' "$icon" "$temperature"
                fi
                ;;
esac
