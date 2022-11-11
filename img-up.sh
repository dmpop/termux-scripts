#!/data/data/com.termux/files/usr/bin/bash

size="1024"
quality="99"
remote_user="foo"
remote_host="hello.xyz"
remote_path="/var/www/html"

if [ ! -x "$(command -v mogrify)" ] || [ ! -x "$(command -v jpegoptim)" ]; then
    echo "Install jhead and jpegoptim"
    exit 1
fi

jhead -n%Y%m%d-%H%M%S *.JPG
for file in *.JPG; do jpegoptim $file "`basename $file .jpg`.jpeg"; done
for file in *.jpeg; do mogrify -resize "$size>" -quality "$quality%" $file; done
for file in *.jpeg; do scp $file "$remote_user@$remote_server:$remove_path"; done