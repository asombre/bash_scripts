#!/bin/bash

journalctl | grep -i virt
echo
tail /var/log/messages
echo
tail /var/log/httpd/error_log 
echo
journalctl --since -3m -t NetworkManager
