#!/bin/bash

loop1=1
loop2=0

loop=1


while [ $loop1 -lt 10 ]
 do 
   while [ $loop2 -lt $loop1 ]
     do 
       echo -n $loop2
       loop2=`expr $loop2 + 1`
     done 
  echo 
       loop1=`expr $loop1 + 1`
 done
