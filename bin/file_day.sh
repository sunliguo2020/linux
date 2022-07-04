#!/bin/bash
# 将当前目录下的文件以其文件修改日期为目录整理
#
#
#2021-05-04:在$MOD_TIME前加./  以防$MOD_TIME 为空
PWD='./'
oldIFS=${IFS}

file_list=`find $PWD  -maxdepth 1  -type f|shuf`

#带有空格的文件名会统计2次
file_count=`echo $file_list |wc -w`
Total=$file_count
IFS=$'\n'

for i in $file_list
do
    echo  Total:$Total#
    {
    MOD_TIME=`stat -c %y $i|awk '{print $1}'`
    if [ ! -d $MOD_TIME ];then
        mkdir ./$MOD_TIME
    fi
    #\mv -iv $i $MOD_TIME/ >/dev/null 2>&1
    \mv -ifv $i ./$MOD_TIME/
     }
     Total=$(($Total-1))
done
wait
IFS=${oldIFS}