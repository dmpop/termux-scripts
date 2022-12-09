#!/data/data/com.termux/files/usr/bin/bash

#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

# Author: Dmitri Popov, dmpop@tokyoma.de
# Source code: https://github.com/dmpop/termux-scripts

if [ ! -x "$(command -v convert)" ] || [ ! -x "$(command -v dialog)" ]; then
    echo "Install imagemagick and dialog"
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
