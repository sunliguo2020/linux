#!/bin/bash
#set -x
cd /root/wordpress/
	md5sum *>md5
	uniq -w 32 md5>uniq
	cut -c35-70 uniq>no_del
	
	dir=$(ls  -t *) 
	for f in $dir
	do
		#echo $dir
		echo -n "$f"
		grep $f no_del>/dev/null
		if [ $? -eq 0 ]
		then
			echo "  no del it "
		else 
			echo "  del it"
			rm -f $f
		fi
#	rm -f $md5 $uniq $no_del
done
