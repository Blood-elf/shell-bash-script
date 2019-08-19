#!/bin/bash

#传入参数判断
if test $# -ne 1
then
	echo "USAGE : sh omp_depre.sh  YYYYMMDD"  #YYYYMMDD:传输日期
	sleep 30s
	exit 1
else
 #用户主目录
 host=omp
 #日期
 dl=${1}
 echo "dl=${dl}"		
fi

#压缩数据文件名存储文件
filename="tar_file.txt"
#数据存放根目录 /home/omp/datas
#ddath=/home/$host/datas
ddath=/home/omp/datas



#创建文件夹
function create_folder(){
	if test ! -d $1 ; then
		mkdir -p $1
	fi
}

list=`find . -name "*.tar.gz" -exec ls {} \;`

#获取文件名将文件名写入文件
function filename-to-file(){
	flag=1

	for file in $list 
	do
		if test $flag -eq 1
		then
			echo "$file" > $filename		
		else
			echo "$file" >> $filename		
		fi
		flag=`expr $flag + 1`
	done
	
	echo "file's number : `expr $flag - 1`"
}

#批量解压 *.tar.gz 文件
function exec_tars_comd(){
	while read line
	do
	
		tar_file_name=`echo ${line}|awk 'BEGIN{FS="/"} {print $2}'`
		echo "programe will tar file : $tar_file_name"
		tar -xzvf $ddath/$tar_file_name -C $ddath/del/$dl/;
		echo "exec command:tar -xzvf $ddath/$tar_file_name -C $ddath/del/$dl/;"
		echo "decompress file ：$ddath/$tar_file_name  success ！"
	done < $filename
	
	returnval=$?
	if test ${returnval} -eq 0 ; 
	then
		echo "decompress files  success ！"	   		
	else
	   echo "decompress files  failed !"
	   exit 1
	fi
}

#清理之前的数据文件，查找更改时间在20天以前的文件并删除
function clean_old_files(){
	find $ddath/del/ -name "*.del" -type f -mtime +20 -exec rm -rf {} \;
}



function depress_file(){

	#获取文件名将文件名写入文件
	filename-to-file

	#创建解压数据存放文件夹 /home/omp/datas/del
	dpath_del=${ddath}/del/${dl}
	create_folder $dpath_del
	
	#创建日志存放文件夹 /home/omp/datas/logs
	dpath_log=${ddath}/logs/${dl}
	create_folder $dpath_log
	
	#创建错误文件存放文件夹 //home/omp/datas/bad
	dpath_bad=${ddath}/bad/${dl}
	create_folder $dpath_bad

	#批量解压文件到 del/2019xxxx 文件夹下
	exec_tars_comd
	
	#清理20天以前的 del 数据文件
	clean_old_files
		
}

depress_file
