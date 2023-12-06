#!/bin/bash

grep "^[a-zA-Z]" /etc/services | awk '{ print $2,$1}' | sort -t/ -k1n | column -t | head -200
