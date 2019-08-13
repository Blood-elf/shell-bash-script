#!/bin/bash
# author:Blood-elf

read -p "input ctl folder name :" foldername
read -p "input file name of ctls :" ctlinfo_filename

ctl_folder=$foldername


if test -e $ctl_folder
then
	rm -rf $ctl_folder
	mkdir $ctl_folder
fi

if test ! -e $ctl_folder
then
	mkdir $ctl_folder
fi


while read line
do
	pre_filename=`echo ${line}|awk '{print $8}'`
	filename=$pre_filename.ctl
	echo $pre_filename
	v_content="${line}"
	echo $v_content > $ctl_folder/$filename

done < $ctlinfo_filename



