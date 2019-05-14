#!/bin/bash
# author:Blood-elf

echo "$0 is running! PID : $$"

#存放 Dockerfile 父级目录，这里设置默认值
path_docker=/home/docker

#手动指定 Dockerfile 父级目录
if test $# -eq 1;then
	path_docker=$1
else
	echo "Default folder to save Dockerfile : /home/docker !"
fi

path_file=$paht_docker/sshd_ubuntu
dockerfile=Dockerfile
run_sh=run.sh

echo "pleas input command : 0 test，1 create,2 delete"
read command

#创建 Dockerfile,run.sh 文件
function create_file(){
	mkdir $path_file
	cd $path_file
	touch $dockerfile $run_sh
	chmod +x $run_sh
	echo "Create file success!"	
	return $?
}

#写入内容到 Dockerfile 文件中用于创建镜像
function write_Dockerfile(){
	echo "# 设置继承镜像" > $dockerfile
	echo "FROM ubuntu:18.04" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#提供一些作者的信息" >> $dockerfile
	echo "MAINTAINER docker_user (user@docker.com)" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "RUN apt-get update" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#安装 ssh 服务" >> $dockerfile
	echo "RUN apt-get install -y openssh-server" >> $dockerfile
	echo "RUN mkdir -p /var/run/sshd" >> $dockerfile
	echo "RUN mkdir -p /root/.ssh" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#安装 net-toos 工具,是能使用 ipfonfig 、 netstat 等网络相关的命令" >> $dockerfile
	echo "RUN apt-get install -y net-tools" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#安装 vim 工具" >> $dockerfile
	echo "RUN apt-get install -y vim" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#取消pam限制" >> $dockerfile
	echo "RUN sed -ri 's#session    required     pam_loginuid.so#session    required     pam_loginuid.so#g' /etc/pam.d/sshd" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#复制配置文件到相应位置，并赋予脚本可执行权限" >> $dockerfile
	echo "ADD authorized_keys /root/.ssh/authorized_keys" >> $dockerfile
	echo "ADD run.sh /run.sh" >> $dockerfile
	echo "RUN chmod 755 /run.sh" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#开放端口" >> $dockerfile
	echo "EXPOSE 22" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#设置自启动命令"	>> $dockerfile
	echo "CMD [\"/run.sh\"]" >> $dockerfile
}

#写入内容到 run.sh 文件中
function write_file(){
	echo "#!/bin/bash" > $run_sh
	echo "/usr/sbin/sshd -D" >> $run_sh
	cp /root/.ssh/id_rsa.pub $path_file/authorized_keys
}

#删除创建的文件
function delete_file(){
	if test -d $path_docker
	then
		rm -rf $path_docker
		echo "Delete folder success !"
		return $?
	else
		echo "Folder is not exist !"
		return $?
	fi
}

#创建镜像
function create_image(){
	docker build -t sshd:dockerfile .
	echo "Create sshd image success !"
}

#测试镜像，运行容器
function run_container(){
	#判断镜像是否创建成功，这里通过创建的数量来确定，然后运行容器
	if [ $(docker images | grep -c "sshd") -gt 1 ];then docker run -d -p 10022:22 --name sshd-dockerfile sshd:dockerfile;fi
	#查看容器是否启动
	if [ $(docker ps | grep -c "sshd-dockerfile") -eq 1 ];then echo "Contain is runing !";fi
}

#test 
if test $command -eq 0
then 
	echo "No task to execute !"

#create file	
elif test $command -eq 1
then
	if test -d $path_docker
	then
		create_file
		echo $?
	else
		mkdir /home/docker
		echo "Creat folder 'docker' success!"
		create_file
		write_file
		write_Dockerfile
		create_image
		run_container
		echo $?
	fi

#delete file	
elif test $command -eq 2
then
	delete_file
	echo $?
else
	echo "Invalid command !"

fi



