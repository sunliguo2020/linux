#########################################################################
# File Name: baoshu.sh
# Author: sunliguo
# mail: sunliguo2006@qq.com
# Created Time: Tue 21 Jun 2016 06:27:18 PM CST
#########################################################################
#!/bin/bash
total=0
echo "###########################"
echo -n
date -R
if [ $# -eq 0 ]; then
  Pwd="."
else
  Pwd=$1
fi
#echo $Pwd
for i in `ls $Pwd`
do
  if [ -d $Pwd/$i ]; then
    echo -ne "$i: \t"
    #printf "$i:\t%d"
    baoshu=$(find $Pwd/$i -type f | wc -l)
    echo $baoshu
    total=$(($total + $baoshu))
  fi
done
printf "Total:\t%d\n" $total
