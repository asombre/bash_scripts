#!/bin/bash

## compare string
if [ 'sda' == 'sdb' ]; then echo "1"; else echo "0";fi

#test directory
if [ -d /run/media/${USER1}/ ]  ; then echo good; else echo bad; fi
if test -d /run/media/${USER1}/  ; then echo good; else echo bad; fi

#man bash "Compound Commands"
#man bash "CONDITIONAL EXPRESSIONS"
dir1="/repo"
dir2="/home/student/vmm_iso"
dir3="/home/student/vmm_volume"
dir4="/home/student/vmm_storage"
dir5="/root/rhel92files"

file1="/root/1_makedirectories.sh"
file2="/root/9_vmsetup.sh"

# q1
echo
echo "q1: does $dir1 exists?"
if (test -d "$dir1")
then echo "yes"
else echo "no"
fi

#q2
echo
echo "q2: does $dir2 exists?"
if
       	`test -d "$dir2"`
then 
	echo "yes"
else
	echo "no"
fi

#q3
echo
echo "q3: does $dir3 and $dir4 exists?"
if `test -d "$dir3" && test -d "$dir4"`
then 
	echo "yes"
else
	echo "no"
fi

#q4
echo
echo "q4: does $dir3 or $dir4 exists?"
if `test -d "$dir3" || test -d "$dir4"`
then 
	echo "yes"
else
	echo "no"
fi

#q5
echo
echo "q5: does $dir5 exists?"
if `test -d "$dir4"`
then 
	echo "yes"
else
	echo "no"
fi

#q6
echo
echo "q6: is $file1 executable?"
if `test -x "$file1"`
then
        echo "yes"
else
	echo "no"
fi

#q7
echo "q7: is $file2 executable?"
if `test -x "$file2"`;then echo "yes"; else echo "no"; fi
