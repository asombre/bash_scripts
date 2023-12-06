#!/bin/bash

date --date="-6 months"
date --date="-6 months" +"%s"
date --date="2023/11/12" +%s

date +%s
echo $(( 1699793710 - 1683896057 ))
echo $(( 15897653 / 60 / 60 / 24 ))
find -maxdepth 1 --mtime +184
