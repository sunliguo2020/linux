#!/bin/bash
# Shell script (BASH) to backup the selected directory on server and upload to 
# another ftp server securely. This script uses the gpg command to 
# encrypt the .tar.gz file before upload take place. 
#
# In order to run this script you must have following tools installed:
# - /usr/bin/ncftpput
# - /bin/tar
# - /usr/bin/mail
# - /usr/bin/gpg
#
# Script also mails back the ftp operation failed or not
#
# Installation:
# Customize the script according to your need. You need to setup ftp 
# server, password etc. Next, you need to setup gpg user name and 
# import public key so that you can encrypt the files. Usually following two 
# commands needed for gpg:
# gpg --import userkey
# gpg --edit-key KEY_ID|USER_ID
# Command>trust
# 
# --------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2005 nixCraft project.
# Feedback/comment/suggestions : http://cyberciti.biz/fb/
# -------------------------------------------------------------------------
# This script is part of nixCraft shell script collection (NSSC)
# Visit http://bash.cyberciti.biz/ for more information.
# -------------------------------------------------------------------------

# Dirs to backup, Separate multiple directories using space 
# for example /home /www /data2
BACKUP="/home"

# Remote ftp server
FTPH="ftp.backup.com"

# Remote ftp user name
FTPU="ftpusername"

# Remote ftp user password
FTPP="secret"

# Local gpg user_id 
GPGU="nixcraft"

# Remote directory, blank for default remote dir
# If dir does not exist it will be created automatically by ncftpput :)
FTPD="backup/"

# Temporary directory to store tar.gz file and process it
TMPD="/tmp"

# Mail message
# Admin email me@mycorp.com or pager@yourmobile.com
MTO="support@mycorp.com"
# Mail subject
MSUB="Backup $(hostname) report"
# Admin info, URL email id; change it according to your need :)
ADMIN_INFO="For support visit http://cyberciti.biz/fb/ or write an email to nobody@cyberciti.biz"

# Only change if your UNIX stores bin in diffrent location
NCFTP="/usr/bin/ncftpput"
TAR="/bin/tar"  # must be gnu tar
MAILC="/usr/bin/mail"
GPG="/usr/bin/gpg"

#######################################################################
# Do not change anything below
#######################################################################
FILE="$(hostname).$(date +"%d-%m-%Y").tar.gz"
OUT="$TMPD/$FILE"
FOUT="$OUT.gpg"
MFILE="/tmp/ftpout.$$.txt"
MESS=""

if [ ! -x $TAR ]; then
  echo "$TAR command not found, contact $ADMIN_INFO" 
  exit 1
fi

if [ ! -x $NCFTP ]; then
  echo "$NCFTP command not found, contact $ADMIN_INFO" 
  exit 1
fi

if [ ! -x $GPG ] ; then
  echo "$GPG command not found, contact $ADMIN_INFO" 
  exit 1
fi

$TAR -zcf $OUT $BACKUP
if [ $? -ne 0 ]; 
then
   MESS="$TAR failed to create backup. Nothing uploaded to remote FTP $FTPH server"
else
   # Encrypt the .tar.gz file before upload
   $GPG -e -r $GPGU -o $FOUT $OUT
   $NCFTP -m -u "$FTPU" -p "$FTPP" "$FTPH" "$FTPD" "$FOUT"
   OSTAT="$?"
   case $OSTAT in
	0) MESS="Success.";;
	1) MESS="Could not connect to remote host $FTPH.";;
        2) MESS="Could not connect to remote host $FTPH - timed out.";;
        3) MESS="Transfer failed.";;
        4) MESS="Transfer failed - timed out.";;
        5) MESS="Directory change failed.";;
        6) MESS="Directory change failed - timed out.";;
        7) MESS="Malformed URL.";;
        8) MESS="Usage error. May be your version of ncftpput ($NCFTP) is old";;
        9) MESS="Error in login configuration file.";;
        10)MESS="Library initialization failed.";;
        11) MESS="Session initialization failed.";;
	*) MESS="Unknown error, contact admin $ADMIN_INFO";;
   esac
fi

>$MFILE
echo "Backup status for $(hostname) as on $(date):" >>$MFILE
echo "" >>$MFILE
echo "Backup File : $FOUT" >>$MFILE
echo "Backup ftp server : $FTPH" >>$MFILE
echo "Backup status message : $MESS" >>$MFILE
echo "" >>$MFILE
echo "-- Automatically generated by $(basename $0)" >>$MFILE

# send an email to admin
$MAILC -s "$MSUB" $MTO <$MFILE
# remove the files 
[ -f $MFILE ] && rm -f $MFILE || :
[ -f $FOUT ] && rm -f $FOUT || :
[ -f $OUT ] && rm -f $OUT || :
