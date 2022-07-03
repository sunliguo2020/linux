#!/bin/bash
trap 'rm -f /tmp/my_tmp$$' INT
echo create /tmp/my_tmp$$
date >/tmp/my_tmp$$

echo "please interrupt (Crtl -c) to intrrupt-----"
 while [ -f /tmp/my_tmp$$ ] ;do
   echo File exits
   sleep  2
 done
 echo The file no longer exists
 trap INT
echo create /tmp/my_tmp$$
date >/tmp/my_tmp$$
echo "press interrupt (Ctrl+c)to interrupt ------"
while [ -f /tmp/my_tmp$$ ];do
  echo file exists
 sleep 3
 done
echo we never get here
exit 0
