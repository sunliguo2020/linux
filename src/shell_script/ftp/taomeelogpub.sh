#!/bin/bash
ls /data/data3/day_published/ |while read userid
do

cd /data/data3/day_published/$userid/ 
find /data/data2/day_published/$userid/* -type d |\
while read aaa
do 
	ln -s $aaa
done
find /data/data4/day_published/$userid/* -type d |\
while read aaa
do
        ln -s $aaa
done

done
