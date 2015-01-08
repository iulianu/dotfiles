#!/bin/bash
# I do this just in case I lose both my primary HDD
# and my Time Machine HDD at once.
# === On Linux
# 10 18    * * *   iulian /home/iulian/dotfiles/lslr-Media.sh
# chmod 644 /etc/cron.d/lslRMedia
# chown root:root /etc/cron.d/lslRMedia
# service cron reload
# === On OS X
# sudo crontab -u root -e
# SHELL=/bin/bash
# MAILTO=iulian
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# 43 19    * * *  /Users/iulian/dotfiles/lslr-Media.sh 

dates=`date "+%Y%m%d"`
fname=medialist-$dates
home=/Users/iulian
itunesfolder=$home/Music/iTunes
calibrefolder="$home/Calibre Library"
secondaryvol=/Volumes/BackupDisk
destination=$home/Dropbox/Reference/media
ls -lR $itunesfolder/iTunes\ Media/ > /tmp/$fname
ls -lR $secondaryvol/MaybeMovies/ >> /tmp/$fname
ls -lR "$calibrefolder/" >> /tmp/$fname
gzip -f /tmp/$fname
mv -f /tmp/$fname.gz $destination/

if [[ $(date +%u) == 1 ]]; then
    # It's a Monday
    cp $itunesfolder/iTunes\ Library.itl $destination/iTunes\ Library\ $dates.itl
fi

if [[ $(date +%u) == 3 ]]; then
    # It's a Wednesday
    cp "$calibrefolder/metadata.db" $destination/calibre-metadata-$dates.db
fi

