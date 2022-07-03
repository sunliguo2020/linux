#!/bin/bash
# Author:
# Purpose: This script monitors Internet Connectivity

ping -c 2 202.194.240.203 >/dev/null

if  ! [ $? !=  0 ]
  then
    echo There seems to be Internet connectivity issues!
fi
