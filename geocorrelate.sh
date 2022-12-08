#!/data/data/com.termux/files/usr/bin/bash

if [ ! -x "$(command -v exiftool)" ]; then
    echo "Install exiftool"
    exit 1
fi

if [ ! -x "$(command -v exiftool)" ]; then
    echo "Install ExifTool."
    exit 1
fi

if [ -f "$2" ]; then
    exiftool -overwrite_original -geotag "$2" -geosync=180 "$1" >>"$PREFIX/tmp/geocorrelate.log" 2>&1
fi
