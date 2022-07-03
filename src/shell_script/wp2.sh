#!/bin/bash
workdictory=/var/sunliguo/wordpress
date=$(date +%Y%m%d%H%M%S)

mysqldump -uroot -psun#gaoTM wordpress >${workdictory}/wp_${date}.sql

cd /www/
tar -cf ${workdictory}/blog_${date}.tar blog

echo "Backup ${workdictory}/blog_${date}.tar wp_${date}.sql"
#cd $workdictory
#7zip a wp_${date}.sql.zip -psun@gao wp_database_${date}.sql blog_${date}.tar

#echo "Backup done !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" 
#cd $workdictory
#
#for i in "blog_${date}.tar" "wp_${date}.sql"
#do
#7zip a -v3m $i.zip -psun@gao $i
#	for ii in `ls -R $i.zip.*`
#	do
#		echo $ii
#mutt -a $ii  -s "`basename $ii`" sunliguo2006@qq.com iamsunliguo@126.com</dev/null
#	rm -f $ii
#	done
#done
find ./ -ctime 1 -name "*tar" -exec rm {} \;
find ./ -ctime 1 -name "*sql" -exec rm {} \;
7zip a wp_${date}.sql.zip -psun@gao $workdictory/wp_${date}.sql
mutt -a wp_${date}.sql.zip -s "wp_${date}.sql" sunliguo2006@qq.com iamsunliguo@126.com </dev/null

