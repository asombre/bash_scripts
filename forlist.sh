#!/bin/bash

# a - find results
# b - create list based on find results
a=$(find -iname song*)
b=($(find -iname song*))

# check for testdir
if (test -d "testdir/")
then 
	echo -e "\033[32mtestdir exists, continuing\033[m"
else 
	bash createtestdir.sh 
	echo -e "\033[31mmessage: created testdir'\033[m"
fi


# find 
echo "find and exec:"
find -iname song* -exec ls -l {} \; | column -t

# a
echo 
echo "find results:"
for i in $a
  do
    echo "list details...$i"
    ls -l $i
  done

# b
echo
echo "1: list default"
echo $b
echo "done"

echo "2: list [0]"
echo ${b[0]}
echo "done"

echo "3: list [1]"
echo ${b[1]}
echo "done"

echo
echo "current directory: $(pwd)"
ls

echo
echo "standby 2s..."
sleep 2s
echo "continuing..."
echo "done"
