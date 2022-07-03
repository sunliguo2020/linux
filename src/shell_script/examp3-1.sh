#!/bin/bash
FILE=/etc/fstab

{
 read line1
 read line2
}<$FILE
echo "First line in $FILE is :"
echo "$line1"
echo "Second line in $FILE is :"
echo "$line2"
exit 0
