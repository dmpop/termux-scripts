#!/data/data/com.termux/files/usr/bin/bash

if [ ! -x "$(command -v convert)" ] || [ ! -x "$(command -v dialog)" ]; then
    echo "Install ImageMagick and dialog"
    exit 1
fi

dialog --erase-on-exit --title "Resize" \
    --form "\n    Specify size and quality" 10 40 2 \
    "  Size (px):" 1 4 "" 1 18 10 10 \
    "Quality (%):" 2 4 "" 2 18 10 10 \
    >dialog.tmp \
    2>&1 >/dev/tty
if [ -s "dialog.tmp" ]; then
    size=$(sed -n 1p dialog.tmp)
    quality=$(sed -n 2p dialog.tmp)
    rm -f dialog.tmp
    convert "$1" -resize "$size>" -quality "$quality%" "${1%/*}/resized_${1##*/}"
else
    exit 1
fi
