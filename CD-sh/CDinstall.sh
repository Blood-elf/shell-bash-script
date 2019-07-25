#!/bin/bash

#输出脚本文件名，和 进程 PID
echo "$0 is running! PID : $$"

#存放 opfile 父级目录，这里设置默认值
cd_root_folder=/home/cdadmin/cdinstall
opfile_name=opfile
opfile=$cd_root_folder/$opfile_name


echo "创建 C:D 用户"
#创建用户
useradd –d /home/cdadmin -m cdadmin
#修改密码
passwd cdadmin

echo "安装前确认没有C:D启动,正在查看C:D进程..."
ps –ef|grep cdpmgr|

#创建 opfile 文件
function create_opfile(){
	cd $cd_root_folder
	touch $opfile_name
	if test -e $opfile;then
		echo "create file success !"
	else
		echo "create file failed !"
	fi
}

#写入内容到 opfile 文件中用于(编写静默安装脚本opfile)
function write_opfile(){
	#默认即可
	echo -e "cdai_trace=\"y\"" >> $opfile_name
	#默认即可
	echo -e "cdai_installCmd=\"install\"" >> $opfile_name
	 # C:D的介质cdunix的路径
	echo -e "cdai_cpioFile=\"/home/cdadmin/cdinstall/cdunix\"" >> $opfile_name
	#C:D安装目录
	echo -e "cdai_installDir=\"/home/cdadmin/cdunix/\"" >> $opfile_name 
	#静默安装脚本opfile的路径
	echo "cdai_spConfig=/home/cdadmin/cdinstall/opfile" >> $opfile_name 
	#C:D安装节点名
	echo "cdai_localNodeName=CDODS" >> $opfile_name 
	#本机 IP地址	
	echo "cdai_acquireHostnameOrIP=192.168.1.18" >> $opfile_name 
	#C:D传输端口，默认即可
	echo "cdai_serverPort=1364" >> $opfile_name
	 #C:D API端口，默认即可
	echo "cdai_clientPort=1363" >> $opfile_name
	#C:D 安装用户，默认即可
	echo "cdai_adminUserid=cdadmin" >> $opfile_name
	#C:D 安装用户，默认即可
	echo "cdai_keystorePassword=password" >> $opfile_name   
}
