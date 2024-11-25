#!/bin/bash

searchswap=swap
searchdisk=vdb1
keydir=/etc/luks-keys
lsblk_cmd="lsblk -o NAME,PATH,FSTYPE,UUID,MOUNTPOINTS -l"
lsblkswap=`$lsblk_cmd | grep $searchswap`
lsblkdisk=`$lsblk_cmd | grep $searchdisk | grep LUKS`
read -r s1 s2 s3 s4 s5 <<<$(echo $lsblkswap)
read -r d1 d2 d3 d4 d5 <<<$(echo $lsblkdisk)
swapname=$s1
swappath=$s2
swaptype=$s3
swapuuid=$s4
swap_mnt=$s5
diskname=$d1
diskpath=$d2
disktype=$d3
diskuuid=$d4
disk_mnt=$d5

function msg () {
	local color=$1
	local message=$2
	if [[ $color == "red" ]]; then
		colornum=31m
	elif [[ $color == "green" ]]; then
		colornum=32m
	elif [[ $color == "yellow" ]]; then
		colornum=33m
	elif [[ $color == "blue" ]]; then
		colornum=34m
	elif [[ $color == "purple" ]]; then
		colornum=35m
	elif [[ $color == "indigo" ]]; then
		colornum=36m
	else
		colornum=41m
	fi
	echo -e "\033[$colornum$message\033[m"
}

function fstab_mount () {
	msg alert "f0..."
	local mount=$1
	echo $mount
	if [[ $mount == "[SWAP]" ]]; then
		echo "none"
	else
		echo $mount
	fi
	msg red "f0."
}

function encrypt_swap () {
	msg green "f1..."
	local path=$1
	local uuid=$2
	echo swapoff UUID=$swapuuid
	luks_encrypt "$swappath" "$swapuuid" "$swaptype" "$swap_mnt"
	echo mkswap /dev/mapper/luks-$swapuuid
	echo swapon /dev/mapper/luks-$swapuuid
	msg red "f1."
}

function create_key () {
	msg green "f2..."
	local uuid=$1
	echo dd if=/dev/random of=$keydir/key-$uuid bs=32 count=1
	msg red "f2."
}

function add_key () {
	msg green "f3..."
	local uuid=$1
	echo cryptsetup luksAddKey UUID=$uuid $keydir/key=$uuid
	#    cryptsetup luksAddKey UUID=$uuid $keydir/key=$uuid
	echo "luks-$uuid UUID=$uuid $keydir/key-$uuid discard" >> /etc/crypttab
	#    "luks-$uuid UUID=$uuid $keydir/key-$uuid discard" >> /etc/crypttab
	msg red "f3."
}

function add_fstab () {
	## uuid, fstype, mount
	msg green "f4..."
	local uuid=$1
	local fstype=$2
	echo $3
	local mnt=`fstab_mount $3`
	#echo "/dev/mapper/luks-$uuid $fstype $mnt defaults 0 0" >> /etc/fstab
	echo "/dev/mapper/luks-$uuid $fstype $mnt defaults 0 0"
	echo " >> /etc/fstab"
	msg red "f4."
}

function luks_encrypt () {
	## path, uuid, fstype, mount
	msg green "f5..."
	local path=$1
	local uuid=$2
	local fstype=$3
	local mount=$4
	echo $path, $uuid, $fstype, $mount.
	echo cryptsetup luksFormat $path --uuid=$uuid
	#echo cryptsetup luksAddKey UUID=$uuid $keydir/key=$uuid
	#echo "luks-$uuid UUID=$uuid $keydir/key-$uuid discard" >> /etc/crypttab
	#echo "/dev/mapper/luks-$f1 $f2 $f2 defaults 0 0" >> /etc/fstab
	add_key $uuid
	add_fstab $uuid $fstype $mount
	echo cryptsetup open UUID=$uuid luks-$uuid --key-file $keydir/key=$uuid
	msg red "f5."

	#cryptsetup luksFormat $e1 --uuid=$e2
	#cryptsetup luksAddKey UUID=$e2 $keydir/key-$e2
	#cryptsetup open UUID=$e2 luks-$e2 --key-file $keydir/key=$e2
}

msg blue "before: $lsblkswap"
msg blue "before: $lsblkdisk"
msg blue "swapdata: ($swapname, $swappath, $swapuuid, $swaptype, $swap_mnt)"
msg blue "diskdata: ($diskname, $diskpath, $diskuuid, $disktype, $disk_mnt)"


## test for key directory
if [ -d $keydir ]; then
	echo "$keydir already created."
else
	mkdir $keydir
fi

## swap
if [[ $lsblkswap == *"luks"* ]]; then
	echo "swap encrypted"
else
	encrypt_swap
fi

## test for keyfile
if [ -f $keydir/key-$swapuuid ]; then
	echo "swap key exists"
else
	#dd if=/dev/random of=$keydir/key-$swapuuid bs=32 count=1
	create_key "$swapuuid"
	echo "created swap key"
fi

## test for keyfile
if [ -f $keydir/key-$diskuuid ]; then
	echo "nfs key exists"
else
	create_key "$diskuuid"
	#dd if=/dev/random of=$keydir/key-$diskuuid bs=32 count=1
	echo "created nfs key"
fi


if [ -f /root/testtest ]; then
	echo "luks-$swapuuid UUID=$swapuuid $keydir/key-$swapuuid discard" >> /etc/crypttab
	echo "luks-$diskuuid UUID=$diskuuid $keydir/key-$diskuuid discard" >> /etc/crypttab
	echo "/dev/mapper/luks-$swapuuid none swap defaults 0 0" >> /etc/fstab
	echo "/dev/mapper/luks-$diskuuid xfs /mnt defaults 0 0" >> /etc/fstab
	
	#cryptsetup luksFormat $diskpath --uuid=$diskuuid
	#cryptsetup luksAddKey UUID=$diskuuid $keydir/key-$diskuuid
	#cryptsetup open UUID=$swapuuid luks-$swapuuid 
	#cryptsetup open UUID=$diskuuid luks-$diskuuid

else
	echo "none"
fi
