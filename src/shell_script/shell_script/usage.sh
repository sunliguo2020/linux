#!/bin/bash
function usage()
{ 
 command=`basename $0`
 echo "usage:$command [options][files]"

}
if test $#!=2
  then
     usage
 fi
