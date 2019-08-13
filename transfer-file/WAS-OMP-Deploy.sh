#!/bin/bash

#部署项目源码
#src_path=/e/Running-File/workspace-idea/omp/cboms/target/omp
#部署项目 was 服务器位置
#was_path=/opt/IBM/WebSphere/AppServer/profiles/Custom01/installedApps/yes55suse12132Cell01/omp1_war.ear/omp.war

base=`pwd`
src_idea_path=/e/Running-File/workspace-idea/omp/cboms/target/omp
src_upload_path=$base/omp
lib_path=$src_upload_path/WEB-INF/lib
#配置文件路径
config_file_path0=$base/uat
config_file_path1=$base/uat1
was_path=/home/omp/home
username=omp
ip=66.6.53.56
log_file=$base/log.txt

#部署项目 jar 包处理
function delete_jars(){
	echo "start delet jars !"  && echo `date` " : start delet jars !" >> $log_file
	cd $lib_path	
	rm `ls | grep -v "cboms-*"`
	echo "delete jars success !" && echo `date` " : delete jars success !" >> $log_file
}

#拷贝源码到上传目录
function copy_src_code(){
	#删除旧文件
	if test -d $src_upload_path
	then
		cd $src_upload_path
		rm -rf *
		echo "clean old file success !" && echo `date` " : clean old file success !" > $log_file
	else
		mkdir $src_upload_path
	fi
	#从 idea 根目录下拷贝出源文件用于修改配置文件
	echo "copy idea src_code to modified"
	cp -r $src_idea_path/* $src_upload_path
	echo "copy src code successful !" && echo `date` " : copy src code successful !" >> $log_file
	
	delete_jars
	
	replace_config
}

#处理配置文件
function replace_config(){
	
	#修改拷贝出来的源文件，修改配置文件
	echo "copy config file bak" && echo `date` " : copy config file bak" >> $log_file
	if test ! -d $config_file_path1
	then
		mkdir $config_file_path1
	fi
	cp -r $config_file_path0/* $config_file_path1 && cp  $config_file_path1/web.xml $src_upload_path/WEB-INF
	rm -f $config_file_path1/web.xml
	cp $config_file_path1/* $src_upload_path/WEB-INF/classes
	rm -rf $config_file_path1
	echo "replace config file success !" && echo `date` " : replace config file success !" >> $log_file 	
}

#文件拷贝上传  传输速度过于缓慢暂不使用
function upload_omp(){
	
	scp -r $src_upload_path ${username}@${ip}:$was_path
	
}



copy_src_code


sleep 6s
