#!/bin/bash

nmcli dev help
nmcli con help

echo "nmcli con show <ip>"
echo "nmcli con add con-name static ifname enp0s31f6 type ethernet ipv4.method manual ipv4.add 172.16.4.1/20 ipv4.dns 172.16.0.1 +ipv4.dns 172.16.0.2 ipv4.gateway 172.16.0.1 ipv4.dns-search lab.net autoconnect yes"
echo "nmcli con add con-name dhcp   ifname enp0s31f6 type ethernet method auto"
echo "nmcli con up static"
echo "nmcli con up dhcp"

nmcli dev
echo
nmcli con
echo
ip a
echo
ip -c a
echo
ip -c -4 a
echo
ip -br -c a
echo
ip -c l
echo
cat /etc/resolv.conf
echo
systemctl status NetworkManager --no-pager
echo
echo
journalctl -t NetworkManager | tail -22
