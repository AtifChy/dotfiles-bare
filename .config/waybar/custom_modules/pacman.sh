#!/bin/sh

check=$(checkupdates)

if [ -z "$check" ]; then
        count=0
else
        pkg=$(echo "$check" | sed -z 's/\n/\\\\n/g')
        pkg="\\\n\\\n${pkg%\\\\n}"
        count=$(echo "$check" | wc -l)
fi

echo "{\"text\": \"${count}\", \"tooltip\": \"${count} available update(s)${pkg}\"}"
