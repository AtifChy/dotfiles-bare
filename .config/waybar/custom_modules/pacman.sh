#!/bin/sh

check=$(checkupdates)

if [ -z "$check" ]; then
        count=0
else
        pkg=$(
                sed -z 's/\n/\\\\n/g' <<-EOF
			$check
		EOF
        )
        pkg="\\\n\\\n${pkg%\\\\n}"
        count=$(
                wc -l <<-EOF
			$check
		EOF
        )
fi

echo "{\"text\": \"${count}\", \"tooltip\": \"${count} available update(s)${pkg}\"}"
