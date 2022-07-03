#!/bin/bash
if test ! $# -eq 1;then
	echo "usage: $0 RESULTDIR"
	exit 1
fi
dirs=`ls -d $1/*`
for i in $dirs;do
	if test ! -e $i/stuinfo; then 
		continue
	fi
	declare `cat $i/stuinfo`
        IFS='/'
        dirnames=($i)
        index=${#dirnames[*]}
        index=$((index-1))
        echo -n "${dirnames[index]} "
        IFS=$'  \r\n'
	echo -n $stuname | ./readanswerline.sh
	echo  " $score $stuphone"
	if test -e $i/others;then
		cat $i/others | ./readanswerline.sh
	else
		echo "file $i/others does not exist!"
	fi
	echo;echo
done
