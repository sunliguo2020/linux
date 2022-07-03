#!/bin/bash


trap "exitprocess" 2
loop=0

function exitprocess()
 {
   echo "You just hit <ctrl-c>  at number $loop"
   echo "I will now exit"
   exit 2
 }

 while true 
 do 
    loop=$[$loop+1]
    sleep 2
    echo $loop
 done
