#!/bin/bash
awk '{printf $1"\n"}' |sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n |uniq -c
