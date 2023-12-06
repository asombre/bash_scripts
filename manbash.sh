#!/bin/bash

man bash | grep "([CM]-.*)" 
echo
man bash | grep "([CM]-.*)" | sort | column -t
echo
man bash | grep "([CM]-.*)" | awk '{ print $2$3$4$5,$1 }' | sort | column -t

