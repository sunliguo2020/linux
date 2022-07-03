#!/bin/bash


trap "exitprocess" 2
h1="/tmp/hold.$$"
h2="/tmp/hold2.$$"
function exitprocess()
{
echo -e "\nRecived Interrupt...."
echo -n "Do you really wish to exit? <Y/N>"
read answer
case $answer in 
  y)
    exit  ;;
  n)
   ;;
esac



}


loop=1
while true 
do
  echo $loop
  sleep 1
  loop=$(($loop+1))
done
