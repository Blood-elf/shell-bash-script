#!/bin/bash
#author blood-elf

#数据导入、导出默认配置参数(这里主要用于同一用户迁移)
user=omp
passwd=omp
db=omp
dest=/home/oracle/exp-datas

#文件传输配置参数(将本地文件传输到远程服务器上)
UName=oracle  #远程服务器登陆用户名
UPasswd=oracle	#远程服务器登陆用户密码
ip=66.6.55.134	#远端服务器 ip 
path=$dest
target=/home/oracle/imp-datas/


#导出数据
function exp-data(){
	create-file $dest
	#exp system/manager@TEST file=d:\daochu.dmp owner=(system,sys)
	echo "$user/$passwd@$db file=$dest/$db.dmp owner=$user"
	#exp $user/$passwd@$db file=$dest/$db.dmp owner=$user
	echo "export data success !"
}

#导入数据
function imp-data(){
	#imp system/orp@orp file=G:\Pro-Bank\orp-zh.dmp full=y
	echo "imp $user/$passwd@$db file=$dest/$db.dmp full=y"
	imp $user/$passwd@$db file=$target/$db.dmp full=y
	echo "imp data success !"
}


#传输数据 $1
function transfer-data-file(){
	create-file $target
	SysType=`uname -s`
	echo SysType:$SysType

	#scp -r /e/scp-source/sharelib/ was@66.6.55.132:/home/was/home/ 

	if test $SysType = "Linux"
	then
		/usr/bin/expect   << EOF
		spawn scp -r $path\$1 $UName@$ip:$target
		set timeout 10
		expect {
		"*Password:" {send "$UPasswd\r"}
		}
		expect "*>"
		set timeout 10
		exit
		expect eof	
EOF
		
	fi	
}

#创建文件夹
function create-file(){
	if test ! -d $1 
	then
		mkdir -p $1
	fi
}


while
do
	echo "pleas choose operate option:1.导出数据 2.导入数据 3.传输数据 0.quit"
	read mode

	case $mode in 
		0) break
		;;
		1) exp-data
		;;
		2) imp-data
		;;
		3) 
		 echo "please choose the file-name you want to transfer :"
		 read file
		 transfer-data-file $file
		;;
	esac
	
done

