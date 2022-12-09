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

work_dir="storage/dcim/Camera"
remote_user="foo"
remote_pass="secret"
remote_host="hello.xyz"
remote_path="/var/www/html"

if [ ! -x "$(command -v jhead)" ] || [ ! -x "$(command -v mogrify)" ] \
|| [ ! -x "$(command -v sshpass)" ] || [ ! -x "$(command -v exiftool)" ]; then
    echo "Install jhead, imagemagick, sshpass, exiftool"
    exit 1
fi

cd $work_dir
mkdir -p results
for file in *; do convert $file -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB results/$file; done
cd results
jhead -n%Y%m%d-%H%M%S *
for file in *; do sshpass -p "$remote_pass" scp $file "$remote_user@$remote_server:$remove_path"; done
