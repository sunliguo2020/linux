#!/bin/bash
LOG=/root/log
if [ ! -e $LOG ]
then
	echo "mkdir $LOG"
	mkdir $LOG
fi
##############################
EXEC_PATH=/root/lib
service=(httpdown )
cd $EXEC_PATH
for LS in $(ls)
do
if [ -d $LS  ];then
:
#echo $LS
fi
done

#############################

for i in ${service[*]}
do
{
#echo $i
	echo "grep mprobe_$i"
	echo  $EXEC_PATH/$i
	ps -ef |grep "mprobe_$i" |grep -v grep
	
	if [ $? -eq 0 ]; then 
		echo "service $i aready running ------,stop";
		killall mprobe_$i
	fi
 
	echo "Run $i ------- starting";
 	
	if [ ! -e ${EXEC_PATH}/$i ];then
		echo  ${EXEC_PATH/}/$i not exiting
	else
		echo "run mprobe_$i"
		cd ${EXEC_PATH}/$i
		./mprobe_$i 1>${LOG}/$(date +%Y%m%d%H%M%S).$i.log.1 2>${LOG}/$(date +%Y%m%d%H%M%S).$i.log.2
	fi

} 
done
