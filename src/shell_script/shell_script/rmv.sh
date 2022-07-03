#/bin/bash
#rmv - a safe delete program
#uses a trash directory under your home directory
#
#when run,always create a directory called .trash
mkdir $HOME/.trash 2>/dev/null
cmdlnopts=false
delete=false
empty=false
list=false
# get any command-line options
 while getopts "deh1" cmdlnopts; do
    case "$cmdlnopts" in
      d) /bin/echo "deleting :\c" $2 $3 $4 $5 ;delete=true ;;
      e) /bin/echo "emptying the trash..." ;empty=true ;;
      h) /bin/echo "rmv -d[elete] -e[mpty] -h [help] -l[ist] file 1-4" ;;
      l) /bin/echo "your .trash directory contains:" ;list=true ;;
    esac
  done
# d -delete any files on the command line
if [ $delete = true ] ; then 
   mv $2 $3 $4 $5 #HOME/.trash
   /bin/echo "rmv finished."
fi

#e -empty the trash?
 if [ $empty = true ] ; then
   /bin/echo "empty the trash \c"
   read answer
   case "$answer" in
     y) rm -rf $HOME/.trash/* ;;
     n) /bin/echo "trashcan delete aborted.";;
    esac
  fi
  

#l show any files in the .trash directory
 if [ $list = true ] ; then
    ls -l $HOME/.trash
  fi
