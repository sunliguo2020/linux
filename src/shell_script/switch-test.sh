#!/bin/bash
function test {
    while read ping_ip
    do
       echo $ping_ip |grep  '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'  

	awk -F ',' '{print $2}'
    done
    }
echo "逸夫楼各层交换机 222.206.96.248-------222.206.96.254"
for ((i=248;i<=254;i++))
  do 
    ping -c 1  222.206.96.${i}|tail -3 | test
 done

echo "图书馆各层交换机 222.206.97.247-*-----222.206.97.254"

for ((i=247;i<=254;i++))
  do 
    ping -c 1  222.206.97.${i}|tail -3| test
 done
echo "8512 NE40 202.194.240.202------------202.194.240.203"
for ((i=202;i<=203;i++))
  do 
    ping -c 1  202.194.240.${i}|tail -3| test
 done
echo "四号楼各层交换机202.194.248.249-----202.194.248.254"
for ((i=249;i<=254;i++))
  do 
    ping -c 1  202.194.248.${i}|tail -3| test
 done
 echo "Firewall 202.194.240.75"
 ping -c 1 202.194.240.75|tail -3 | test

echo "办公楼各层交换机202.194.249.250-----202.194.249.254"
for ((i=250;i<=254;i++))
  do 
    ping -c 1  202.194.249.${i}|tail -3| test
 done
for ((i=252;i<=254;i++))
  do 
    ping -c 1  202.194.250.${i}|tail -3 | test
 done
echo ”二号楼conclude。经验显示：2号楼第一个answer包响应事件可能大于100ms，故发2次。“
for ((i=251;i<=254;i++))
  do 
    ping -c 2  202.194.247.${i}|tail -3 | test
 done
 echo "一号楼202.194.246.253-202.194.246.254"
 ping -c 2 202.194.246.253|tail -3| test
 ping -c 2 202.194.246.254|tail -3 | test
 echo "一号楼Intel交换机202.194.246.2"
 ping -c 2 202.194.246.2|tail -3| test

 ping 222.206.100.25 -c 2|tail -3| test
 ping 202.194.240.30 -c 1|tail -3| test
 ping 202.194.249.1 -c 1|tail -3| test
 ping 202.194.250.1 -c 1|tail -3| test
 ping 202.194.252.254 -c 1 |tail -3| test
 ping 202.194.254.254 -c 1|tail -3| test
 ping 202.194.249.177 -c 1|tail -3 | test
 ping 222.206.110.5  -c 1|tail -3| test
 ping 202.194.245.254 -c 1|tail -3| test
 ping 202.194.245.1 -c 1|tail -3| test
 ping 202.194.240.97 -c 1|tail -3| test
 ping 202.194.240.100 -c 1|tail -3| test
 ping 202.194.240.90 -c 1|tail -3| test
 ping 202.194.240.88 -c 1|tail -3| test
