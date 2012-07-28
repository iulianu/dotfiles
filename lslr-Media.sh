#!/bin/bash
# 10 18    * * *   iulian /home/iulian/dotfiles/lslr-Media.sh
# chmod 644 /etc/cron.d/lslRMedia
# chown root:root /etc/cron.d/lslRMedia
# service cron reload

dates=`date "+%Y%m%d"`
fname=medialist-$dates
ls -lR /home/iulian/Music/ > /tmp/$fname
ls -lR /home/iulian/Store/Movies/ >> /tmp/$fname
ls -lR /home/iulian/Store/DE_VAZUT/ >> /tmp/$fname
gzip -f /tmp/$fname
mv -f /tmp/$fname.gz /home/iulian/Dropbox/Reference/media/

