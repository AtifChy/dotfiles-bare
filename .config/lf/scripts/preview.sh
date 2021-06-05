#!/bin/sh
draw() {
        path="$(printf '%s' "$1" | sed 's/\\/\\\\/g;s/"/\\"/g')"
        printf '{"action": "add", "identifier": "preview", "x": %d, "y": %d, "width": %d, "height": %d, "scaler": "contain", "scaling_position_x": 0.5, "scaling_position_y": 0.5, "path": "%s"}\n' \
                "$x" "$y" "$width" "$height" "$path" >"$FIFO_UEBERZUG"
        exit 1
}

hash() {
        printf '%s/.cache/lf/%s' "$HOME" \
                "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
        if [ -f "$1" ]; then
                draw "$1"
        fi
}

if ! [ -f "$1" ] && ! [ -h "$1" ]; then
        exit
fi

file="$1"
width="$(($2 - 1))"
height="$3"
x="$4"
y="$5"

default_x="1920"
#default_y="1080"

case "$file" in
*.7z | *.a | *.ace | *.alz | *.arc | \
        *.arj | *.bz | *.bz2 | *.cab | \
        *.cpio | *.deb | *.gz | *.iso | \
        *.jar | *.lha | *.lrz | *.lz | \
        *.lzh | *.lzma | *.lzo | *.rar | \
        *.rpm | *.rz | *.t7z | *.tar | *.tbz | \
        *.tbz2 | *.tgz | *.tlz | *.txz | \
        *.tZ | *.tzo | *.war | *.xz | *.Z | \
        *.zip | *.zst)
        bsdtar --list --file "$file"
        exit 0
        ;;
*.svg)
        if [ -n "$FIFO_UEBERZUG" ]; then
                cache="$(hash "$file").jpg"
                cache "$cache"
                convert -- "$file" "$cache"
                draw "$cache"
        fi
        ;;
esac

case "$(file -Lb --mime-type -- "$file")" in
text/* | application/json)
        bat --style plain --theme base16 --color always "$file"
        ;;
*/pdf)
        if [ -n "$FIFO_UEBERZUG" ]; then
                cache="$(hash "$file").jpg"
                cache "$cache"
                pdftoppm -f 1 -l 1 \
                        -scale-to-x "$default_x" \
                        -scale-to-y -1 \
                        -singlefile \
                        -jpeg \
                        -- "$file" "$cache"
                draw "$cache"
        else
                pdftotext "$file" -
        fi
        ;;
image/*)
        if [ -n "$FIFO_UEBERZUG" ]; then
                orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
                if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
                        cache="$(hash "$file").jpg"
                        cache "$cache"
                        convert -- "$file" -auto-orient "$cache"
                        draw "$cache"
                else
                        draw "$file"
                fi
        else
                chafa --fill=block --symbols=block "$file"
        fi
        ;;
video/*)
        if [ -n "$FIFO_UEBERZUG" ]; then
                cache="$(hash "$file").jpg"
                cache "$cache"
                ffmpegthumbnailer -i "$file" -o "$cache" -s 0
                draw "$cache"
        else
                mediainfo "$file"
        fi
        ;;
audio/*)
        mediainfo "$file"
        ;;
*)
        file -Lb --mime-type -- "$file"
        ;;
esac

exit 0
