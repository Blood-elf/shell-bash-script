#!/bin/bash
# author:Blood-elf

read -p "input ctl folder name :" foldername
read -p "input file name of ctls :" ctlinfo_filename

bat_folder=$foldername
root_bat=$bat_folder/start_batch.bat

if test -e $bat_folder
then
	rm -rf $bat_folder
	mkdir $bat_folder
fi

if test ! -e $bat_folder
then
	mkdir $bat_folder
fi

if test ! -e $root_bat
then
	touch $root_bat
	echo '@echo off' > $root_bat
fi

while read line
do
	pre_filename=`echo ${line}|awk '{print $8}'`
	echo $pre_filename
	filename=$pre_filename.bat
	echo ${line} > $bat_folder/$filename
	echo call $filename >> $root_bat
	echo del $filename >> $root_bat
done < $ctlinfo_filename

echo del start_batch.bat >> $root_bat


