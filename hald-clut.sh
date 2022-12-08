#!/data/data/com.termux/files/usr/bin/sh

# Original script: https://github.com/PixlsStuff/Scripts/edit/master/android_filmsim/filmsim.sh

if [ ! -x "$(command -v convert)" ] || [ ! -x "$(command -v jq)" ] || [ ! -x "$(command -v termux-toast)" ]; then
    echo "Install termux-api, imagemagick, jq"
    exit 1
fi

mkdir -p $HOME/storage/dcim/HCLUT
cd $HOME/storage/dcim/HCLUT
photo="photo.jpg"
hclut="hald-clut.png"
photo_checksum=$(stat -c %Y $photo)
termux-toast "Choose a JPEG file to process"
termux-storage-get $photo
while [ $(stat -c %Y $photo) -eq $photo_checksum ]; do
    sleep 1
done
termux-toast "Choose the desired Hald CLUT file"
hclut_checksum=$(stat -c %Y $hclut)
termux-storage-get $hclut
while [ $(stat -c %Y $hclut) -eq $hclut_checksum ]; do
    sleep 1
done
result=$(termux-dialog -t "Resulting file name" -i "result.jpg" | jq '.text' | tr -d '"')
termux-toast "Processing..."
convert $photo $hclut -hald-clut $result
rm $photo $hclut
termux-toast "All done!"
exit 0
