#!/bin/bash

cat /etc/passwd
echo
cat /etc/passwd | column -s : -t
echo
cat /etc/passwd | column -s : -t | awk '{ print $1, $3, $4 }' | column -t | sort
