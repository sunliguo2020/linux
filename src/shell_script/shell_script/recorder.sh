#/bin/bash
#recorder - record sound to disk file 
if [ $# != 2 ];then
echo  usage : recorder [n] soundfilename
else
{
  echo -ne "recording  "
  echo -ne $1
 echo -ne "  second of sound to "
 echo $2.au
 /bin/dd bs=8k count=$1 </dev/audio >$2.au
}
fi
