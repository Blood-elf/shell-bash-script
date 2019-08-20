#!/bin/bash

cboms_parent_path=/e/Running-File/workspace-idea/omp-svn/cboms-parent		#部署需要根据实际修改
cboms_path=/e/Running-File/workspace-idea/omp-svn/cboms			#部署需要根据实际修改
log_file=log.txt

function cboms_parent_clean(){
	#cboms-parent clean
	cd $cboms_parent_path
	mvn clean
	r1=$?
	if test r1 -eq 0
	then
		echo "cboms_parent clean success !" && echo `date` : "cboms_parent clean success !" > $log_file
	else
		echo "cboms_parent clean failed !" && echo `date` : "cboms_parent clean failed !" > $log_file
	fi
}

function cboms_parent_install(){
	#cboms-parent install
	cd $cboms_parent_path
	mvn install
	r1=$?
	if test r1 -eq 0
	then
		echo "cboms_parent install success !" && echo `date` : "cboms_parent install success !" > $log_file
	else
		echo "cboms_parent install failed !" && echo `date` : "cboms_parent install failed !" > $log_file
	fi	
}

function cboms_clean(){
	#cboms clean
	cd $cboms_path
	mvn clean
	r1=$?
	if test r1 -eq 0
	then
		echo "cboms_web clean success !" && echo `date` : "cboms_web clean success !" > $log_file
	else
		echo "cboms_web clean failed !" && echo `date` : "cboms_web clean failed !" > $log_file
	fi	
}

function cboms_install(){
	#cboms install
	cd $cboms_path
	mvn install
	r1=$?
	if test r1 -eq 0
	then
		echo "cboms_web install success !" && echo `date` : "cboms_web install success !" > $log_file
	else
		echo "cboms_web install failed !" && echo `date` : "cboms_web install failed !" > $log_file
	fi	
}

function web_package(){
	cboms_parent_clean
	cboms_parent_install
	cboms_clean
	cboms_install
}

function boot(){
	echo "请选择操作模式:1)mvn 打包;0)exit"
	read model
	
	if test $model -eq 1
	then
		web_package
	elif test $model -eq 0
	then
		exit 0
	else
		echo "无效指令!"
	fi
	
}

boot