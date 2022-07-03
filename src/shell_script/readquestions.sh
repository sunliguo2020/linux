#!/bin/bash
formvalue=${QUERY_STRING}
IFS='&'
declare $formvalue
IFS=$' 	\r\n'
echo -n $'Content-type: text/plain\n'
echo -n $'\n'
if test "$stuno" == "" -o "$subject" == "";then
	echo 'can not be empty!'
	exit 1;
fi
cat $subject/quesresu/results/$stuno/questions.txt
