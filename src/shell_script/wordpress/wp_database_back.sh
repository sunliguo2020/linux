#!/bin/bash
workdictory=/root/wordpress
date=$(date +%Y%m%d%H%M%S)
mysqldump -uroot -psun#gaoTM wordpress >${workdictory}/wp_database_${date}.sql

cd /www/
tar -cf ${workdictory}/blog_${date}.tar blog

echo "Backup ${workdictory}/blog_${date}.tar wp_database_${date}.sql"
#cd $workdictory
#7zip a wp_${date}.sql.zip -psun@gao wp_database_${date}.sql blog_${date}.tar

#rm -f blog_${date}.tar wp_database_${date}.sql
echo "Backup done !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "#############del double file###############"
#echo ${workdictory}
#. ${workdictory}/double.sh
echo "@@@@@@@@@@@@@done del double file@@@@@@@@@@@@"
file=(tar sql)
for i in ${file[*]}
do
#	echo "$i all mail file"
	ls -lt ${workdictory}/*${i} 2>/dev/null|grep $i 1>/dev/null 2>/dev/null
if [ $? -gt 0 ]
then
#	echo " '$?' > 0"	
	echo "no file to mail"
else
	{
	new=`ls -lt ${workdictory}/*${i}|awk '{print $9}'|head -1 `
echo "new ===  $new"
if [ -f "$new" ] 
then
	echo "mail $new"
	cd $workdictory
	7zip a $new.zip -psun@gao $new
	mutt -a $new.zip  -s "$(date +%Y%m%d%H%M%S) `basename $new.zip`" sunliguo2006@qq.com iamsunliguo@126.com</dev/null
	mv $new $new.mail
	echo "del $new.zip"
	rm -f $new.zip
fi
}
fi
done
find ./ -ctime 1 -name "*mail" -exec rm {} \;
