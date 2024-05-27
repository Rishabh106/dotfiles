#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"

airport="$(networksetup -getairportnetwork en0)"
UPDOWN="$(ifstat -i "en0" 0.1 1 | tail -n 1)"
DOWN_SPEED=$(($(echo "$UPDOWN" | awk "{ print \$1 }" | cut -f 1 -d ".")))
UP_SPEED=$(($(echo "$UPDOWN" | awk "{ print \$2 }" | cut -f 1 -d ".")))

if [ ! -z $(echo $airport | grep "You are not associated with an AirPort network." ) ]; then
    sketchybar -m --set $NAME icon.drawing=off
elif [ $UP_SPEED -gt $DOWN_SPEED ]; then
    sketchybar -m --set $NAME icon.drawing=on icon=$UPLOAD
    if [ $UP_SPEED -gt 999 ]; then
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $UP_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
else
    sketchybar -m --set $NAME icon.drawing=on icon=$DOWNLOAD
    if [ $DOWN_SPEED -gt 999 ]; then
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f MB/s", $1 / 1000}')
    else
        SPEED=$(echo $DOWN_SPEED | awk '{ printf "%.1f KB/s", $1}')
    fi
fi

sketchybar -m --set $NAME label="$SPEED"
