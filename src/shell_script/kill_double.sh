#!/bin/bash
find $1 -type f -exec md5sum {} \; >/tmp/first

awk '{printf $1 "\n"}' /tmp/first >/tmp/first.new

sort /tmp/first.new >/tmp/two

uniq -d /tmp/two >/tmp/sort

for i in `cat /tmp/sort`
do
    grep $i /tmp/first 
    echo 
done >/tmp/result
