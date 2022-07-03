#!/bin/bash

#split file into pieces


usage ()
{
  echo "usage: basename $0 -b [M] -m [mode] files "

}

if test  $# -lt 3 
  then
   
   usage
fi
