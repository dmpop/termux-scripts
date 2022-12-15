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

if [ ! -x "$(command -v exiftool)" ]; then
    echo "Install exiftool"
    exit 1
fi

mkdir -p $HOME/storage/dcim/Clean
cd $HOME/storage/dcim/Clean

photo=$(mktemp)
photo_checksum=$(stat -c %Y $photo)
result=$(date +"%Y%m%d-%H%M%S").jpg
termux-toast "Choose a JPEG file to resize"
termux-storage-get $photo
while [ $(stat -c %Y $photo) -eq $photo_checksum ]; do
    sleep 1
done

exiftool -all= "$photo" -o "$result"
termux-toast "All done!"