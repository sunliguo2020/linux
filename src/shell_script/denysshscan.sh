#! /bin/bash
# 获取前 1 分钟内的 secure 记录，统计 ssh 认证失败的 IP 和其 失败次数
#SCANNER=`grep "\`date \"+ %e %H:%M\" -d \"-1min\"\`" /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $1"="$2;}'`
SCANNER=`grep "Apr 24"  /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $1"="$2;}'`

for i in $SCANNER
do
        # 取认证失败次数
        NUM=`echo $i|awk -F= '{print $1}'`
	# 取其 IP 地址
        IP=`echo $i|awk -F= '{print $2}'`

        # 若其在失败次数超过 5 次且之前没有被阻断过，那么添加一条策略将其阻断，并记录日志
      #  if [ $NUM -gt 5 ] && [ -z "`iptables -vnL INPUT|grep $IP`" ]
        if [ $NUM -gt 5 ] 
        then
      #       iptables -I INPUT -s $IP -j DROP
             #  echo "`date` $IP($NUM)" >;>; /var/log/scanner.log
               echo "`date` $IP($NUM)" 
        fi
done

