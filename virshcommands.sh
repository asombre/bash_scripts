#!/bin/bash

virsh list
virsh list --all
virsh list --all --name
virsh dumpxml 1 | head
virsh dumpxml 1 | tail
virsh domdisplay 1
virsh domblklist 1
virsh domblkinfo vda
virsh domblkinfo 1 vda
virsh domblkinfo 1 vda --human
virsh dommemstat 1
virsh domfsinfo 1
virsh pool-list

echo "virsh start 1"
echo "virsh stop 1"
