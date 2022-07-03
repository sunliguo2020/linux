#/bin/bash
part="/mnt/wine"
LOOK_OUT=`df|grep "$part"|awk '{print $5}'|sed 's/%//g'`
echo $LOOK_OUT
if [ $LOOK_OUT -gt 90 ]
 then
    echo "dasfdsa"
fi
until [ "$LOOK_OUT" -gt "333" ]
 do
    echo "files sdf"
done
