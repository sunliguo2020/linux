#!/bin/bash
while getopts f:0:v OPTION;
 do
   case "$OPTION" in
      f) echo f;;
      o) echo o;;
      v) echo v;;
      *) echo error;;
   esac
 done
