#!/bin/bash
x=0
while [ $x -lt 10 ]
do 
   #echo "$x\c"
   y=0
  while [ $y -le $x ]
    do
      echo -n "$y "
      y=$(($y+1))
    done
    echo
  x=$(($x+1))
 done
