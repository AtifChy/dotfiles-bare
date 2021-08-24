#!/bin/sh

pkg=$(checkupdates | wc -l)
echo "{\"text\": \"${pkg}\", \"tooltip\": \"${pkg} available update(s)\"}"
