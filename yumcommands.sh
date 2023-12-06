#!/bin/bash

yum list httpd 
yum search vim
yum info httpd
yum clean all
yum makecache
yum update httpd -y
yum update -y

