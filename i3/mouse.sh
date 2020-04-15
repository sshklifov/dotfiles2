#!/bin/bash

kb="pointer:Ducky Ducky One2 Mini RGB"
regex='[0-9]+\.0+'

coef=$(xinput list-props "$kb" | grep "Transformation Matrix" | grep -o -E "$regex")
x=$(head -n 1 <<< "$coef" | cut -d '.' -f 1)

if [ "$x" -eq 2 ]; then
    newx=10
else
    newx=2
fi

xinput set-prop "$kb" "Coordinate Transformation Matrix" $newx 0 0 0 $newx 0 0 0 1
notify-send.sh -t 1500 --replace-file=/tmp/mousenotif "kb speed: $newx"
