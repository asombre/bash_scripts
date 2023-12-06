#!/bin/bash

for i in $(ls README*); do echo; echo "#### $i"; cat $i; done > savedreadmefiles_$(date +%Y%m%d)

