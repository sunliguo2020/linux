#!/bin/sh
LANG=C

#被监控服务器、端口列表
server_all_list=(\
192.168.1.4:21 \
192.168.1.9:21 \
192.168.1.4:445 \
192.168.1.9:445 \
)

date=$(date -d "today" +"%Y-%m-%d_%H:%M:%S")

#采用HTTP POST方式发送检测信息给接口程序interface.php，接口程序负责分析信息，决定是否发送报警MSN消息。
send_msg()
{
   /usr/bin/curl -m 600 -d menu=tcp -d date=$date -d ip=$server_ip -d port=$server_port -d status=$status http://127.0.0.1/boobooke.php
}

server_all_len=${#server_all_list[*]}
i=0
while  [ $i -lt $server_all_len ]
do
   server_ip=$(echo ${server_all_list[$i]} | awk -F ':' '{print $1}')
   server_port=$(echo ${server_all_list[$i]} | awk -F ':' '{print $2}')
       #status:    0,http down    1,http ok    2,http down but ping ok 
       if nc -vv -z -w 10 $server_ip $server_port > /dev/null 2>&1
       then
           status=1
           echo "服务器${server_ip}，端口${server_port}能够正常访问！"
       else
           if ping -c 1 $server_ip > /dev/null 2>&1
           then
               status=2
               echo "服务器${server_ip}，端口${server_port}无法访问，但是能够Ping通！"
           else
               status=0
               echo "服务器${server_ip}，端口${server_port}无法访问，并且无法Ping通！"
           fi
       fi
   send_msg
   let i++
done

