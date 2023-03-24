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

# Author: Dmitri Popov, dmpop@cameracode.coffee
# Source code: https://github.com/dmpop/termux-scripts

local_dir="/path/to/source/dir"
remote_user="user"
remote_passwd="secret"
remote_server="hello.xyz"
remote_dir="/path/to/remote/dir"

if [ ! -x "$(command -v rsync)" ] || [ ! -x "$(command -v sshpass)" ]; then
    echo "Install rsync and sshpass"
    exit 1
fi

sshpass -p "$remote_passwd" rsync -avhz --exclude=".*" --delete -P -e "ssh -p 22" "$local_dir/" "$user"@"$remote_server":"$remote_dir"