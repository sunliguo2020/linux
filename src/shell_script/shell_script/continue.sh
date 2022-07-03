#!/bin/bash
#continue
while :
 do
     echo -n "Enter any number [1-5]"
  read ans
   case $ans in 
     1|2|3|4|5)
        echo "You enter a number between $ans ";;
     *)
        echo -n "Wrong number ,continue(y/n)"
         read continue
          case $continue in 
            y|yes|Y)
                 continue;;
            *)
              break;;
           esac
     esac
done
