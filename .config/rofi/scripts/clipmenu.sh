#!/bin/sh

if [ "$@" ]; then
        value=$(printf '%b\n' "$@")
        [ "$(wl-paste)" = "$value" ] && exit
        wl-copy -n <<-EOF
		$value
	EOF
        exit 0
fi

clipman pick --tool STDOUT
