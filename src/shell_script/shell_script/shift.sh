#!/bin/bash
#shift.sh
usage()
{
 echo "usage:`basename $0` filenames"

}
  
totalline=0


if [ $# -lt 2 ]
 then
      usage
      exit
fi
while [ $# -ne 0 ]

do
  line=`cat $1|wc -l`
  echo "$1:$line"
  totalline=$[ ${totalline}+${line} ]
  shift
done
echo "-------"

echo "total :$totalline"
