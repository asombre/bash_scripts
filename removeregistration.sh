#!/bin/bash

dir1=/lib/systemd/user/org.gnome.SettingsDaemon.Subscription.service
## vim /lib/systemd/user/org.gnome.SettingsDaemon.Subscription.service
## comment out ExecStart=/usr/libexec/gsd-subman

grep -z --color ExecStart=/usr/libexec/gsd-subman $dir1

echo
echo "################"
echo "vim $dir1"
echo "sudo vim $dir1"
echo "comment ExecStart"
echo "yum remove subscription-manager-cockpit"


