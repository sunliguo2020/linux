#!/bin/bash

#mv /home/taomee_log/begin/* /home/taomee_log/backup/

declare -i lst1 lst7 ago tmp total
#lst1=`date -d '-1 days' +%Y%m%d`
#lst7=`date -d '-7 days' +%Y%m%d`
#tmp=$lst7
#ago=7
#while [ $tmp -le $lst1 ]
#do
#cd /data/data*/day_published/2350/`echo $tmp` ; ls *.gz |while read aaa;do (zcat `echo $aaa` | awk '{print $2}' |sort |uniq |wc -l |xargs echo $aaa) >>/home/taomee_log/begin/$tmp.txt;done &

tmp=`date -d '-1 days' +%Y%m%d`


cd /data/data*/day_published/2350/`echo $tmp` ; ls *.gz |grep -v -f '/home/taomee_log/channelpass' |while read aaa;do (zcat `echo $aaa` | awk '{print $2}' >> /home/taomee_log/tmp/$aaa.tmp) && (cat /home/taomee_log/tmp/$aaa.tmp |sort |uniq >> /home/taomee_log/tmp/$aaa)&& rm -f /home/taomee_log/tmp/$aaa.tmp ;done &



#ago=$ago-1
#tmp=`date -d '-'$ago' days' +%Y%m%d`
#done

