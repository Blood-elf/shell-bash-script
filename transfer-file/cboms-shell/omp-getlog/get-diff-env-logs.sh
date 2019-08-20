#!/bin/bash

base=`pwd`
echo 基准路径 : $base

log_file=get_log.txt

function choice_cmd(){
	echo "please choose env to export file: 1 ft ; 2 uat-132 ; 3 uat-133 ; 0 exit"
	read env
}

function init_param(){
	echo "exec init_param" >> $log_file
	if test $env -eq 1  # ft env
	then
		UName=omp
		UPasswd=omp
		ip=66.6.53.56
		src_path_f1=/opt/IBM/WebSphere/AppServer/profiles/Custom01/logs/OMPSERVER/SystemErr.log
		src_path_f2=/opt/IBM/WebSphere/AppServer/profiles/Custom01/logs/OMPSERVER/SystemOut.log
		dest_path=${base}/logs/ft
		echo "ft env : omp/omp"
	elif test $env -eq 2  #uat env-132
	then
		UName=was
		UPasswd=was
		ip=66.6.55.132
		src_path_f1=/opt/IBM/WebSphere/AppServer/profiles/Custom01/logs/omp-server132/SystemErr.log
		src_path_f2=/opt/IBM/WebSphere/AppServer/profiles/Custom01/logs/omp-server132/SystemOut.log
		dest_path=${base}/logs/uat-132
		echo "uat env 132: was/was"
	elif test $env -eq 3  #uat env-133
	then
		UName=was
		UPasswd=was
		ip=66.6.55.133
		src_path_f1=/opt/IBM/WebSphere/AppServer/profiles/Custom02/logs/omp-server133/SystemErr.log
		src_path_f2=/opt/IBM/WebSphere/AppServer/profiles/Custom02/logs/omp-server133/SystemOut.log
		dest_path=${base}/logs/uat-133
		echo "uat env : was/was"		
	elif test $env -eq 0
	then 
		echo "exit"
		exit 0
	else
		echo "pleas input correct value !"
	fi
}

function create_folder(){
	echo "exec create_folder" >> $log_file
	if test ! -d $dest_path 
	then
		mkdir -p $dest_path
		echo "create folder $dest_path"
	fi
}

function download_file1(){
	echo "exec download_file1 : $src_path_f1" >> $log_file
	scp  $UName@$ip:$src_path_f1 $dest_path
}

function download_file2(){
	echo "exec download_file2 : $src_path_f2" >> $log_file
	scp  $UName@$ip:$src_path_f2 $dest_path
}

function boot(){
	echo "boot script !" > $log_file
	choice_cmd
	init_param
	create_folder
	download_file1
	download_file2
	start "" $dest_path
	sleep 3s
}

boot





