#!/data/data/com.termux/files/usr/bin/bash

remote_user="foo"
remote_host="hello.xyz"
remote_pass="secret"
local_path="/path/to/source/dir"
remote_path="/path/to/remove/dir"

if [ ! -x "$(command -v rsync)" ] || [ ! -x "$(command -v sshpass)" ]; then
    echo "Install rsync and sshpass"
    exit 1
fi

sshpass -p "$remote_pass" rsync -avhz --delete -P -e "ssh -p 22" "$user@$remote_server:$remote_path/ $local_path"