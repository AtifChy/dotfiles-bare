#!/bin/sh

if [ "$@" ]; then
        value=$(printf '%s\n' "$@" | sed 's/\033/\\\0/g')
        value=$(printf '%b\n' "$value")
        [ "$(wl-paste)" = "$value" ] && exit
        wl-copy -n <<-EOF
		$value
	EOF
        exit 0
fi

clipman pick --tool STDOUT
