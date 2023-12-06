#!/bin/bash

for i in $(ls *.sh); do echo; echo "#### $i"; cat $i; done > savedshellscripts_$(date +%Y%m%d)

