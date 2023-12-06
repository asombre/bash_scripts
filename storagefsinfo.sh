#!/bin/bash

du -sh
df -h
lsblk
lsblk -fs
parted /dev/sda1 print
fdisk -l /dev/sda
parted /dev/sda1 print
