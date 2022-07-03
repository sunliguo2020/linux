#!/bin/bash
curren_date=`date "+%Y%m%d"`
locallog="${curren_date}.log"

if [ ! -f $locallog ]
 then
    touch $locallog
fi
