#!/bin/bash
IFS=$' \t\r\n;'
echo -n $'Content-type: text/html'
echo -n $'\n\n'
echo '<html>'
echo '<head>'
echo '<meta http-equiv="content-type" content="text/html;charset=gb2312">'
echo '</head>'
echo '<body>'
countperpage=10
IFS='&'
declare ${QUERY_STRING}
IFS=$' 	\n\r'
if test ! -d $time;then
	echo " can not find directory $time!"
	exit 1
fi
filenames=(`ls $time`)
if test "$filenames" == "";then
	echo "no picture in $time"
	exit 1;
fi
if test "$startno" == "";then
	startno=0;
fi
if test "$endno" == "";then
	if test ${#filenames[*]} -lt $countperpage;then
		endno=$((${#filenames[*]}-1))
	else
		endno=$(($countperpage-1));
	fi
fi
for (( i=$startno ; $endno-$i+1 ; i=i+1 ));do
	if echo ${filenames[i]} | sed "s/\(.*\.\)//g" | grep -i jpg >/dev/null;then 
		echo "<a href=$time//${filenames[i]} target=_blank><img src=$time/${filenames[i]} height=300  border=0></a>"	
	else
		echo "<a href=$time//${filenames[i]}><img src=notpic.jpg width=420 height=300 border=0></a>"	
	fi
done
echo "<br>"
if test $((${#filenames[*]}%$countperpage)) -eq 0;then
	pages=$((${#filenames[*]}/countperpage));
else
	pages=$((${#filenames[*]}/countperpage+1))
fi
echo "分页："
if test ! $startno -le 0;then
	 echo "<a href=\"show.sh?time=$time&startno=$(($startno-$countperpage))&endno=$(($startno-1))\">[prev]</a>&nbsp"
fi
for (( i=0 ; $pages-$i ; i=i+1 ));do
	if test ! $((startno/countperpage)) -eq $i;then
	if test $((pages-i)) -eq 1;then
		echo "<a href=\"show.sh?time=$time&startno=$((i*countperpage))&endno=$((${#filenames[*]}-1))\">[$((i+1))]</a>&nbsp"
	else
		echo "<a href=\"show.sh?time=$time&startno=$((i*countperpage))&endno=$(((i+1)*countperpage-1))\">[$((i+1))]</a>&nbsp"
	fi
	else
		echo "$((i+1))&nbsp;"
	fi
done
if test ! $((startno/countperpage+1)) -eq $pages;then
        if test $((pages-startno/countperpage)) -eq 2;then
                echo "<a href=\"show.sh?time=$time&startno=$(($startno+$countperpage))&endno=$((${#filenames[*]}-1))\">[next]</a>"
        else
                echo "<a href=\"show.sh?time=$time&startno=$(($startno+$countperpage))&endno=$(($startno+2*$countperpage-1))\">[next]</a>"
        fi

fi
echo '</body>'
echo '</html>'


