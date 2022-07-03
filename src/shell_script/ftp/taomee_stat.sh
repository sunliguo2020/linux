#!/bin/bash

tmp=20101129

cd  /home/taomee_log/tmp/;ls *`echo $tmp`*.gz |while read aaa;do (cat `echo $aaa`  |sort |uniq |wc -l |xargs echo $aaa) >> /home/taomee_log/begin/$tmp.txt;done 

(cat /home/taomee_log/tmp/*`echo $tmp`*.gz |sort |uniq |wc -l ) >> /home/taomee_log/begin/total_`echo $tmp`.txt
