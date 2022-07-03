#!/bin/bash
while read line
 do
   case $line in
    *root*) echo $line;;
   esac
 done</etc/passwd
