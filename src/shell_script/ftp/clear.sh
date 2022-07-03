#!/bin/bash

find /data/data1/source/ -type f -mtime +5 -exec rm {} \;
find /data/data1/source_bak/ -type f -mtime +3 -exec rm {} \;
find /data/data2/day_published/ -type f -mtime +30 -exec rm {} \;
find /data/data3/day_published/ -type f -mtime +30 -exec rm {} \;
find /data/data4/day_published/ -type f -mtime +30 -exec rm {} \;


find /data/data*/day_published/ -type d -mtime +35 |while read aaa;do rm -rf $aaa;done
