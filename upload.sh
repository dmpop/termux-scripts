#!/data/data/com.termux/files/usr/bin/bash

wrk_dir="storage/dcim/Camera"
remote_user="foo"
remote_pass="secret"
remote_host="hello.xyz"
remote_path="/var/www/html"

if [ ! -x "$(command -v mogrify)" ] || [ ! -x "$(command -v jpegoptim)" ] || [ ! -x "$(command -v sshpass)" ]; then
    echo "Install jhead, imagemagick, sshpass"
    exit 1
fi

cd $wrk_dir
mkdir -p results
for file in *; do convert $file -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB results/$file; done
cd results
jhead -n%Y%m%d-%H%M%S *
for file in *; do sshpass -p "$remote_pass" scp $file "$remote_user@$remote_server:$remove_path"; done
