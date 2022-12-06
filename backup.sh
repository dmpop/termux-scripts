#!/data/data/com.termux/files/usr/bin/bash

local_dr="/path/to/source/dir"
remote_user="foo"
remote_server="hello.xyz"
remote_passwd="secret"
remote_dir="/path/to/remote/dir"

if [ ! -x "$(command -v rsync)" ] || [ ! -x "$(command -v sshpass)" ]; then
    echo "Install rsync and sshpass"
    exit 1
fi

sshpass -p "$remote_passwd" rsync -avhz --exclude=".*" --delete -P -e "ssh -p 22" "$local_dir/" "$user"@"$remote_server":"$remote_dir"