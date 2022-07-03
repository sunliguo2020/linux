#!/bin/bash
MD5SUM_FILE=blog_database.sum
MD5SUM_FILE_UNIQ=${MD5SUM_FILE}.uniq
NO_DEL=blog_database.file
md5sum *tar >$MD5SUM_FILE
uniq -w 32 $MD5SUM_FILE>$MD5SUM_FILE_UNIQ
cut -c35-70 $MD5SUM_FILE_UNIQ>$NO_DEL
file=$(ls *tar)
fileno=$(ls -l *tar |wc -l)
#echo "fileno= $fileno"
for f in $file
do
        echo "fffffff= $f"
        grep $f $NO_DEL >/dev/null
        if [ $? -eq 0 ]
        then
                :
        else
                echo del $f
                rm $f
        fi
done

