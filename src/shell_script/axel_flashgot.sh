#!/bin/bash

#axel_flashgot.sh
#This is a script meant for the firefox extension Flashgot to run axel
if [! -d ~/Desktop/download ];then
 mkdir ~/Desktop/download
 else

  cd ~/Desktop/download
  gnome-terminal -command="axel -a -S 3 $1"
#axel -q -o ~/Desktop/download $1 &
#gnome-terminal -command="axel -a -S 3 $1"
fi
