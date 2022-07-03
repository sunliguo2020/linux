#!/bin/bash

MYUSER="root"
MYPASS="admin"
HOST="localhost"
BACKUPDIR="/mnt/TNAS_SUN"

DATE=$(date -I)
RETENTION=20
#MYSQLDATA="/var/lib/mysql"

[ ! -d $BACKUPDIR/$DATE ] && mkdir -p $BACKUPDIR/$DATE

#DBS=`mysql -u$MYUSER -p$MYPASS -Bse "show databases"|grep -v "information_schema" |grep -v "test"`
DBS='crawl'
for db_name in $DBS; do

  mkdir -p $BACKUPDIR/$DATE/$db_name
  tables=$(mysql -u$MYUSER -p$MYPASS -Bse "use $db_name;show tables")

  for table_name in $tables; do
    echo $table_name
    mysqldump -u$MYUSER -p$MYPASS -h$HOST $db_name $table_name >$BACKUPDIR/$DATE/$db_name/$table_name.sql

  done
done
