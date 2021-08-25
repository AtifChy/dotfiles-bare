#!/bin/sh

check=$(checkupdates)
test -z "$check" && count=0 || {
	pkg=$(echo "$check" | sed -z 's/\n/\\\\n/g')
	pkg="\\\n\\\n${pkg%\\\\n}"
	count=$(echo "$check" | wc -l)
}
echo "{\"text\": \"${count}\", \"tooltip\": \"${count} available update(s)${pkg}\"}"
