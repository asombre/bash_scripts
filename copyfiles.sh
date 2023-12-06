#!/bin/bash

cd /run/media/student//rhel92ext/
cp rhel92.tar.gz /root

cd /root
sha256sum -c redhatlinux.sha256
