#!/data/data/com.termux/files/usr/bin/sh

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

if [ ! -x "$(command -v convert)" ] || [ ! -x "$(command -v termux-toast)" ]; then
    echo "Install termux-api, imagemagick"
    exit 1
fi

usage() {
    cat <<EOF
$0 [OPTIONS]
------
$0 applies Hald CLUT presets to the specified JPEG file.

USAGE:
------
  $0 -i <image file> -d <directory>

OPTIONS:
--------
  -i Path to a JPEG file
  -d Path to directory containing Hald CLUT presets
EOF
    exit 1
}
while getopts "i:d:" opt; do
    case ${opt} in
    i)
        img=$OPTARG
        ;;
    d)
        haldcluts=$OPTARG
        ;;
    \?)
        usage
        ;;
    esac
done
shift $((OPTIND - 1))

if [ -z "$img" ] || [ -z "$haldcluts" ]; then
    usage
    exit 1
fi

results=$HOME/storage/dcim/Results
if [ -d "$results" ]; then
    rm -rf "$results"
    mkdir -p "$results"
fi

img_name=$(basename "$img")
convert "$img" -resize "800>" "tim-$img_name"

for file in "$haldcluts"/*.png; do
    haldclut_name="${file##*/}"
    echo "Applying ${haldclut_name%.*} Hald CLUT..."
    convert "tim-$img_name" "$file" -hald-clut "$results/${haldclut_name%.*}-$img_name"
    convert "$results/${haldclut_name%.*}-$img_name" -gravity South -background Black -pointsize 100 -fill White -font Roboto -splice 0x120 -annotate 0x0 "${haldclut_name%.*}" "$results/${haldclut_name%.*}-$img_name"
done
rm "tim-$img_name"
echo "All done! Open $results to see the results."
