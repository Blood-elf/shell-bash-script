#!/bin/bash

#基准路径
base=`pwd`
#源码出处
src_idea_path=/e/Running-File/workspace-idea/omp-svn/cboms/target/omp  #部署需修改
#部署项目所用源码
src_upload_path=$base/omp
#部署项目所用源码 lib 包所在位置
lib_path=$src_upload_path/WEB-INF/lib
#日志配置
log_file=$base/log.txt


#根据参数值，决定初始化
function conifg_model(){
	echo "please choose init parame env : 0 uat-default ; 1 uat-sso ;2 ft ; 4 test-model;"
	read model
	
	if test $model -eq 0 
	then
		#无参启动，默认为 uat 部署
		#uat was 服务器
		was_path=/opt/IBM/WebSphere/AppServer/profiles/Custom01/installedApps/yes55suse12132Cell01/omp1_war.ear/omp.war
		#配置文件路径
		config_file_path0=$base/uat
		config_file_path1=$base/uat1
		#远程服务器配置
		username=was
		ip=66.6.55.134	
	elif test $model -eq 1
	then
		#ft 环境部署 sso
		was_path=/opt/IBM/WebSphere/AppServer/profiles/Custom01/installedApps/yes53suse12056Cell01/omp1_war.ear/omp.war
		#配置文件路径
		config_file_path0=$base/uat-sso
		config_file_path1=$base/uat-sso-1
		#远程服务器配置
		username=omp
		ip=66.6.53.56		
	elif test $model -eq 2
	then
		#ft 环境部署
		was_path=/opt/IBM/WebSphere/AppServer/profiles/Custom01/installedApps/yes53suse12056Cell01/omp1_war.ear/omp.war
		#配置文件路径
		config_file_path0=$base/ft
		config_file_path1=$base/ft1
		#远程服务器配置
		username=omp
		ip=66.6.53.56
	else
		#ft 测试部署
		was_path=/home/omp/home/omp.war
		#配置文件路径
		config_file_path0=$base/ft
		config_file_path1=$base/ft1
		#远程服务器配置
		username=omp
		ip=66.6.53.56	
	fi
}


#拷贝源码到上传目录
function copy_src_code(){
	#删除旧文件
	if test -d $src_upload_path
	then
		cd $src_upload_path
		rm -rf *
		echo "clean old file success !" && echo `date` " : clean old file success !" >> $log_file
	else
		mkdir $src_upload_path
	fi
	#从 idea 根目录下拷贝出源文件用于修改配置文件
	echo "copy idea src_code to modified"
	cp -r $src_idea_path/* $src_upload_path
	echo "copy src code successful !" && echo `date` " : copy src code successful !" >> $log_file	
	
}

#部署项目 jar 包处理  删除除 cboms 开头的其他 jar 文件
function delete_jars(){
	echo "start delete jars !"  && echo `date` " : start delet jars !" >> $log_file
	if test -d $lib_path 
	then 
		cd $lib_path	
		rm `ls | grep -v "cboms-*"`
	else
		echo $lib_path " is not exists !" && echo `date` $lib_path " is not exists !" >> $log_file
		exit 1
	fi
	echo "delete jars success !" && echo `date` " : delete jars success !" >> $log_file
}

#处理配置文件
function replace_config(){
	
	#修改拷贝出来的源文件，修改配置文件
	echo "copy config file bak" && echo `date` " : copy config file bak" >> $log_file
	if test ! -d $config_file_path1
	then
		mkdir $config_file_path1
	fi
	cp -r $config_file_path0/* $config_file_path1 
	cp  $config_file_path1/web.xml $src_upload_path/WEB-INF && cp  $config_file_path1/web_merged.xml $src_upload_path/WEB-INF 
	rm -f $config_file_path1/web.xml && rm -f $config_file_path1/web_merged.xml
	cp $config_file_path1/* $src_upload_path/WEB-INF/classes
	rm -rf $config_file_path1
	echo "replace config file success !" && echo `date` " : replace config file success !" >> $log_file 	
}

#文件拷贝上传  传输速度过于缓慢根据情况使用
function upload_omp(){
	echo "start war deploye !" && echo `date`  : "start war deploye !" >> $log_file
	echo "scp -r $src_upload_path/* ${username}@${ip}:$was_path" && echo "scp -r $src_upload_path/* ${username}@${ip}:$was_path" >> $log_file
	scp -r $src_upload_path/* ${username}@${ip}:$was_path
	echo "finished war depoy ! success !" && echo `date`  : "finished war depoy ! success !" >> $log_file
}

#只处理配置文件
function upload_model_1(){
	#初始化配置
	conifg_model
	copy_src_code
	replace_config	
	echo "处理配置文件完成!"
	start "" $src_upload_path
}

#只处理配置文件且全部上传
function upload_model_2(){
	upload_model_1
	upload_omp
	echo "处理配置文件且全部上传!"
}

#仅处理配置文件和删除jar包
function upload_model_3(){
	#初始化配置
	conifg_model
	copy_src_code
	delete_jars
	replace_config
	echo "处理配置文件和删除jar包完成!"
	start "" $src_upload_path
}

#处理配置文件和jar包，并上传
function upload_model_4(){
	upload_model_3
	upload_omp
	echo "处理配置文件和jar包，并上传完成"
}

function choice_option_model(){
	echo "请选择部署方案:"
	echo "**1)脚本处理配置文件,手动上传!"
	echo "**2)脚本处理配置文件,自动上传!"
	echo "**3)脚本处理配置文件和删除jar包,手动上传!"
	echo "**4)脚本处理配置文件和删除jar包,自动上传!"
	echo "请根据上面提示，输入模式序号:" 
	read option
	
	if test $option -eq 1 
	then
		upload_model_1
	elif test $option -eq 2
	then
		upload_model_2
	elif test $option -eq 3
	then
		upload_model_3
	elif test $option -eq 4
	then
		upload_model_4
	else
		echo "无效输入!"
		sleep 6s
		exit 1
	fi
}

function boot(){
	choice_option_model
	start "" $base
}

boot

sleep 30s
