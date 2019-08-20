#!/bin/bash

base=`pwd`

function choice_model(){
	echo "选择需要的操作:"
	echo "	1)项目部署;" 
	echo "	2)日志获取;"
	echo "	3)信息查询;"
	echo "	0)exit"
	read model
	
	if test $model -eq 1
	then
		cd $base/omp-deploy
		./WAS-OMP-Deploy_Update.sh	
	elif test $model -eq 2
	then
		cd $base/omp-getlog
		./get-diff-env-logs.sh
	elif test $model -eq 3
	then
		cd $base/omp-info-check
		./get-info.sh		
	elif test $model -eq 0
	then
		exit 0
	else 
		echo "无效命令,重新输入!"
	fi
}

function boot(){
	choice_model
}

while :
do
	boot
done
