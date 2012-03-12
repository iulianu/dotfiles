#!/bin/bash
# 10 17    */2 * *   iulian /home/iulian/dotfiles/lslr-Media.sh
# chmod 644 /etc/cron.d/lslRMedia
# chown root:root /etc/cron.d/lslRMedia
# service cron reload

dates=`date "+%Y%M%d"`
fname=medialist-$dates
ls -lR /home/iulian/Music > /tmp/$fname
ls -lR /home/iulian/Store/Movies >> /tmp/$fname
ls -lR /home/iulian/Store/DE_VAZUT >> /tmp/$fname
gzip /tmp/$fname
mv /tmp/$fname.gz /home/iulian/Dropbox/media/

