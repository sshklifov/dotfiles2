#!/bin/bash

id=$(xdotool search --name "^$(basename $1)")
nmatches=$(wc -w <<< "$id")
if [ $nmatches -ne 1 ]; then
    msg=$(echo -e "Failed to find nvim instance\n\
File: $1\n\
Line: $2")
    notify-send --icon qpdfview "$msg"
    exit 1
fi

xdotool windowactivate --sync $id
xdotool type --clearmodifiers --delay 1 "$2"
xdotool key --clearmodifiers --delay 1 "shift+g"
