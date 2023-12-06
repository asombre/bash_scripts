#!/bin/bash

cat cleancomments.sh
echo
sed 's/httpd.conf/httpd.conf.new/g' cleancomments.sh 
echo
cat cleancomments.sh

echo
echo "sed 's/httpd.conf/httpd.conf.new/g' cleancomments.sh"
echo "sed 's/httpd.conf/httpd.conf.new/g' cleancomments.sh"
echo
echo "sed -i 's/httpd.conf/httpd.conf.new/g' cleancomments.sh"
echo "sed -i 's/httpd.conf.new/httpd.conf/g' cleancomments.sh"
