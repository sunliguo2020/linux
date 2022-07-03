#!/bin/bash
#kill_process

curren_PID=$$

ps aux|grep "httpd" |grep -v "grep"|awk '{print $2}'>/tmp/${cureen_PID}.txt

for pid in `cat /tmp/${cureen_PID}.txt`

  do
     echo $pid
  done

 rm -f /tmp/${cureen_PID}.txt
