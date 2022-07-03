#!/bin/bash
#Author : sunliguo
#Date : 5.1.2008
#Purposr : Illustrate how to abstract daily log entries
mydate=`date +%b\ %d`
log1=/var/log/messages
log2=/var/log/maillog

echo $mydate
for log in $log{1,2}
do
  echo $log BEGIN
  grep -E "$mydate" $log
  echo $log END
  echo 
done

