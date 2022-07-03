#!/bin/bash
printf "%15s %s\n" "Filename  Type"

for i in $(ls); do
 printf "%15s" "$i "
  if [ -d $i ];then
    echo "directory"
  fi

  if [ -f $i ];then
    echo "file"
  fi
done
