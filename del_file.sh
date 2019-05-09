#!/bin/bash
#author:blood-elf

del_path=/opt/IBM/WebSphere/AppServer/profiles/Custom01

echo "Do you want to delete file(y/n):"
read command

if test $command = 'y'
then
	find $del_path -name "Snap.*.trc" -type f -ok rm -f {} \;
	find $del_path -name "hapdump.*.phd" -type f -ok rm -f {} \;
	find $del_path -name "javacore.*.txt" -type f -ok rm -f {} \;
else

fi























