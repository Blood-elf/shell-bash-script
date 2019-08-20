#!/bin/bash

database_info=database.txt
was_console_info=was_console_add.txt
was_deploy_info=was_deploy.txt
was_log_info=was_log.txt
web_cache_info=webxml_catch.txt

function choice_model(){
 
	echo "选择你需要查询的信息:"
	echo "  1)was 控制台信息及服务器信息;"
	echo "  2)was 项目部署位置信息;"
	echo "  3)was 日志信息;"
	echo "  4)数据库信息;"
	echo "  5)web.xml缓存路径信息;"
	echo "  6)jar 包替换路径;"
	echo "  0)退出"
	echo "请输入查询信息序号:"
	read model

	if test $model -eq 1 
	then
		filename=$was_console_info
	elif test $model -eq 2
	then
		filename=$was_deploy_info
	elif test $model -eq 3
	then
		filename=$was_log_info
	elif test $model -eq 4
	then
		filename=$database_info
	elif test $model -eq 5
	then
		filename=$web_cache_info		
	elif test $model -eq 0
	then
		echo "exit!"
	else
		echo '你没有输入 1 到 4 之间的数字'
		sleep 6s && exit 1
	fi	
	
}

function read_file(){
	echo " ************ start ************ "
	echo ""
	while read line
	do
		echo "	"$line
	done < $filename
	echo ""
	echo " ************ end ************ "
}

function boot(){
	choice_model
	read_file
}


boot

