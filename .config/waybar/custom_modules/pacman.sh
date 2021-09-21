#!/bin/sh

check=$(checkupdates)

if [ -z "$check" ]; then
        count=0
else
        pkg=$(
                sed -z 's/\n/\\n/g' <<-EOF
			$check
		EOF
        )
        pkg="\\n\\n${pkg%\\n}"
        count=$(
                wc -l <<-EOF
			$check
		EOF
        )
fi

printf '{"text": "%s", "tooltip": "%s available update(s)%s"}\n' "$count" "$count" "$pkg"
