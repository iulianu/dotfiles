#!/bin/bash
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
secondaryvol=/Volumes/2tb-p2
ls -lR $secondaryvol/iTunes\ Media/Music > /tmp/$fname
ls -lR $secondaryvol/Movies/ >> /tmp/$fname
gzip -f /tmp/$fname
mv -f /tmp/$fname.gz $home/Dropbox/Reference/media/

