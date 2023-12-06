#!/bin/bash

configfile=httpd.conf.new
grep -v "^#\|^$" $configfile

echo
echo "$(wc -l $configfile | awk '{ print $1 }') total lines with comments"
echo "$(grep -v "^#\|^$" $configfile | wc -l) total lines without comments"
