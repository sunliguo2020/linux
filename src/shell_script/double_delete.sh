#!/bin/bash
cd /root/wordpress/
file=(tar sql)
#echo ${file[*]}
for i in ${file[*]}
do
	#echo $i
	md5=${i}.sum
	uniq=${md5}.uniq
	no_del=${i}.nodel
	md5sum *${i}>$md5
	uniq -w 32 $md5>$uniq
	cut -c35-70 $uniq>$no_del
	dir=$(ls *$i)
	for f in $dir
	do
		echo "$f"
		grep $f $no_del>/dev/null
		if [ $? -eq 0 ]
		then
			echo no del it 
		else
			echo del $f
			rm -f $f
		fi
	done
find ./ -ctime +1 -name "*$i" -exec rm {} \;
rm -f $md5 $uniq $no_del
done
