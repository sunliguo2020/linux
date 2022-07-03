#!/bin/bash
#sed ls -l


lsl=`ls -l`

echo $lsl|sed -e '/-*/
