#!/bin/bash
IFS=$' \t\r\n;'
echo -n $'Content-type: text/html'
echo -n $'\n\n'
echo '<html>'
echo '<head>'
echo '<meta http-equiv="content-type" content="text/html;charset=gb2312">'
echo '</head>'
echo '<body>'
cat ./index.html
echo '</body>'
echo '</html>'
