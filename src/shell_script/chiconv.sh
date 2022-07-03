#!/bin/bash
if [ $# -gt 0  -a -f $1 ];then
cp $1 ${1}.old
iconv -f gb2312 -t utf-8 $1 -o ${1}.utf
if [ $? -eq 0 ];then
cat ${1}.utf >$1
rm -f ${1}.utf
fi
else
	echo "$0 file"
fi
