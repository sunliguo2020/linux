#!/bin/bash

mv /home/taomee_log/begin/* /home/taomee_log/backup/

declare -i lst1 lst7 ago tmp total
lst1=`date -d '-1 days' +%Y%m%d`
lst7=`date -d '-7 days' +%Y%m%d`
tmp=$lst7
ago=7
while [ $tmp -le $lst1 ]
do
#cd /data/data*/day_published/2350/`echo $tmp` ; ls *.gz |while read aaa;do (zcat `echo $aaa` | awk '{print $2}' |sort |uniq |wc -l |xargs echo $aaa) >>/home/taomee_log/begin/$tmp.txt;done &

#ls /home/taomee_log/*`echo $tmp`*.gz |while read aaa;do (zcat `echo $aaa` | awk '{print $2}' |sort |uniq >> /home/taomee_log/tmp/$aaa) ;done 

cd  /home/taomee_log/tmp/;ls *`echo $tmp`*.gz |while read aaa;do (cat `echo $aaa`  |sort |uniq |wc -l |xargs echo $aaa) >> /home/taomee_log/begin/$tmp.txt;done 

(cat /home/taomee_log/tmp/*`echo $tmp`*.gz |sort |uniq |wc -l ) >> /home/taomee_log/begin/total_`echo $tmp`.txt

ago=$ago-1
tmp=`date -d '-'$ago' days' +%Y%m%d`
done

cd /home/taomee_log/TaomeeStatistics/; /usr/java/jdk1.6.0_21/bin/java -jar /home/taomee_log/TaomeeStatistics/TaomeeStatistics.jar  


#mv /home/taomee_log/begin/* /home/taomee_log/backup/
#rm -f /home/taomee_log/tmp/*
