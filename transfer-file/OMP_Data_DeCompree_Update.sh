#!/bin/bash

#��������ж�
if test $# -ne 1
then
	echo "USAGE : sh omp_depre.sh  YYYYMMDD"  #YYYYMMDD:��������
	sleep 30s
	exit 1
else
 #�û���Ŀ¼
 host=omp
 #����
 dl=${1}
 echo "dl=${dl}"		
fi

#ѹ�������ļ����洢�ļ�
filename="tar_file.txt"
#���ݴ�Ÿ�Ŀ¼ /home/omp/datas
#ddath=/home/$host/datas
ddath=/home/omp/datas



#�����ļ���
function create_folder(){
	if test ! -d $1 ; then
		mkdir -p $1
	fi
}

list=`find . -name "*.tar.gz" -exec ls {} \;`

#��ȡ�ļ������ļ���д���ļ�
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

#������ѹ *.tar.gz �ļ�
function exec_tars_comd(){
	while read line
	do
	
		tar_file_name=`echo ${line}|awk 'BEGIN{FS="/"} {print $2}'`
		echo "programe will tar file : $tar_file_name"
		tar -xzvf $ddath/$tar_file_name -C $ddath/del/$dl/;
		echo "exec command:tar -xzvf $ddath/$tar_file_name -C $ddath/del/$dl/;"
		echo "decompress file ��$ddath/$tar_file_name  success ��"
	done < $filename
	
	returnval=$?
	if test ${returnval} -eq 0 ; 
	then
		echo "decompress files  success ��"	   		
	else
	   echo "decompress files  failed !"
	   exit 1
	fi
}

#����֮ǰ�������ļ������Ҹ���ʱ����20����ǰ���ļ���ɾ��
function clean_old_files(){
	find $ddath/del/ -name "*.del" -type f -mtime +20 -exec rm -rf {} \;
}



function depress_file(){

	#��ȡ�ļ������ļ���д���ļ�
	filename-to-file

	#������ѹ���ݴ���ļ��� /home/omp/datas/del
	dpath_del=${ddath}/del/${dl}
	create_folder $dpath_del
	
	#������־����ļ��� /home/omp/datas/logs
	dpath_log=${ddath}/logs/${dl}
	create_folder $dpath_log
	
	#���������ļ�����ļ��� //home/omp/datas/bad
	dpath_bad=${ddath}/bad/${dl}
	create_folder $dpath_bad

	#������ѹ�ļ��� del/2019xxxx �ļ�����
	exec_tars_comd
	
	#����20����ǰ�� del �����ļ�
	clean_old_files
		
}

depress_file
