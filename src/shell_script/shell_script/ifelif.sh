#!/bin/bash
#usage
# if list1 
#   then 
#     list2
#  elif list3
#    then
#     list4
#   else 
#     list5
#  fi
echo "Is it morning?  Please answer yes or no!"

read timetody

if [ "$timetody" == "yes" ]; then
  echo "Good morning!"
 elif [ "$timetody" == "no" ];then
   echo "Good afternoon!"
  else 
      echo "Sorry ,$timeday not recognized.Enter yes or no"
      exit 1
fi
exit 0
