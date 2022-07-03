# !/bin/sh

from_name="from@yanggang"
from="yanggang@ftsmobile.com"
to="376440229@qq.com"
#to="sunliguo@yahoo.cn"

email_title="Test Mail"
email_content="/etc/passwd"
email_subject="dsfsadfsafssdfSA"

echo -e "To: \"${email_title}\" <${to}>\nFrom: \"${from_name}\" <${from}>\nSubject: ${email_subject}\n\n`date`" | /usr/sbin/sendmail -t
