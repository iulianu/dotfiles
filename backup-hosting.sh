#!/bin/bash
# sudo crontab -u root -e
# SHELL=/bin/bash
# MAILTO=iulian
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# 02 16    * * 0  /Users/iulian/WorkDev/dotfiles/backup-hosting.sh 
# ----
# The file hosting-credentials.sh should have the following format
# sysshortname=webhost
# syshost=webhost.domain.com
# identity=id_dsa_file
# mysql_databases=nameofdb
# mysqlpwd=pAssw0rd
# files="/var/www /etc/apache2 /etc/proftpd /etc/mysql"
# logfiledirs="apache2"

dates=`date "+%Y%m%d"`
home=/Users/iulian
. $home/WorkDev/dotfiles/hosting-credentials.sh
destinationroot=$home/Dropbox/Reference/hosting-backups
destination=$destinationroot/$sysshortname/$dates
SSHARGS="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i $identity"
SSHCMD="ssh $SSHARGS -l root $syshost"
remotetempdir=tbackup-$dates

mkdir -p $destination

$SSHCMD "mkdir -p $remotetempdir/dumps && for lf in '$logfiledirs'; do mkdir -p $remotetempdir/logfiles/\$lf && mv /var/log/\$lf/*.gz $remotetempdir/logfiles/\$lf; done"
$SSHCMD "tar c $files | gzip > $remotetempdir/dumps/files.tgz"
$SSHCMD "mysqldump -u root -p$mysqlpwd  $mysql_databases | gzip > $remotetempdir/dumps/mysql.tgz"
scp $SSHARGS -r root@$syshost:$remotetempdir/* $destination/
chown -R iulian $destinationroot
$SSHCMD "rm -rf $remotetempdir/dumps"

