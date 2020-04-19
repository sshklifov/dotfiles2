#!/bin/bash

id=$(xdotool search --name "^$(basename $1)")
nmatches=$(wc -w <<< "$id")
if [ $nmatches -ne 1 ]; then
    notify-send.sh -t 2500 \
        "Failed to find nvim instance.\nReverse forward search result: $2"
    exit
fi

xdotool windowactivate --sync $id
xdotool type --clearmodifiers --delay 1 "$2"
xdotool key --clearmodifiers --delay 1 "shift+g"
