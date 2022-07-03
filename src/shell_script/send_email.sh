# !/bin/sh

from='root@sgbaba.com'
#to='iamsunliguo@163.com'
to='sunliguo2006@qq.com'

email_date=''
email_content='/var/spool/lpd/1.html'

function send_email(){
    email_date=$(date "+%Y-%m-%d_%H:%M:%S")
    #echo $email_date

email_subject='Top800_Game_Free_USA'
    email_subject=$email_subject"__"$email_date
#    echo $email_subject

    cat $email_content | formail -I "From: $from" -I "To: $1" -I "MIME-Version:1.0" -I "Content-type:text/html;charset=utf-8" -I "Subject: $email_subject" |/usr/sbin/sendmail -oi $1
}
for i in `cat qqlist.txt`
do
echo $i

send_email $i
done
