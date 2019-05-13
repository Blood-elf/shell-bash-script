#!/bin/bash
#author:blood-elf
#url:https://github.com/Blood-elf

#输出脚本文件名，和 进程 PID
echo "$0 is running! PID : $$"

#存放 Dockerfile 父级目录，这里设置默认值
docker_root_folder=/home/docker

#手动指定 Dockerfile 父级目录
if test $# -eq 1;then
	docker_root_folder=$1
else
	echo "Default folder to save Dockerfile : /home/docker !"
fi

#存放 Dockerfile 的目录
dockerfile_parent_folder=$docker_root_folder/apache_ubuntu
#sample 站点目录
sample_folder=sample
#sample 下页面
index_page=./$sample_folder/index.html

#需要创建的文件：Dockerfile 镜像文件，run.sh 容器运行时启动的脚本文件
dockerfile=Dockerfile
run_sh=run.sh

#选择脚本执行模式， 0 测试脚本，1 创建 Dockerfile及其他相关文件， 2 清空所有创建文件，用于重新创建文件
echo "pleas input command : 0 test，1 create,2 delete"
read command

#创建 Dockerfile 文件
function create_file(){
	mkdir $dockerfile_parent_folder
	cd $dockerfile_parent_folder
	#创建 Dockerfile、run.sh 文件，并对 run.sh 文件增加执行权限
	touch $dockerfile $run_sh
	chmod +x $run_sh 
	#创建站点目录
	mkdir $sample_folder 
	touch $index_page
	
	echo "Create file success!"	
	return $?
}

#写入内容到 Dockerfile 文件中用于创建镜像
function write_Dockerfile(){
	echo "# 设置继承自用户创建的 sshd 镜像" > $dockerfile
	echo "FROM sshd:dockerfile" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#创建者基本信息" >> $dockerfile
	echo "MAINTAINER docker_user (anself@docker.com)" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#设置环境变量，所有操作都是非交互式的" >> $dockerfile
	echo "ENV DEBIAN_FRONTEND noninteractive" >> $dockerfile  
	echo -e "\n\r" >> $dockerfile
	
	echo "#安装" >> $dockerfile
	echo "RUN apt-get install -yd tzdata && apt-get -yd install apache2 && \\" >> $dockerfile
	echo -e "\t rm -rf /var/lib/apt/lists/* " >> $dockerfile 
	echo -e "\n\r" >> $dockerfile

	echo "#注意这里要更改系统的时区设置，因为在 Web 应用中经常会用到时区这个系统变量，默认 Ubuntu 的设置会让你的应用程序发生不可思议的效果哦" >> $dockerfile	
	echo "RUN echo \"Asia/Shanghai\" > /etc/timezone && \\" >> $dockerfile
	echo -e "\t dpkg-reconfigure -f noninteractive tzdata" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#添加用户的脚本，并设置权限，这回覆盖之前放在这个位置的脚本" >> $dockerfile
	echo "ADD run.sh /run.sh" >> $dockerfile
	echo "RUN chmod 775 /*.sh" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo -e "#添加一个示例的Web站点，删掉默认安装在 apache 文件夹下面的文件，\c" >> $dockerfile
	echo "并将用户添加的示例用软连接链接到 /var/www/html 目录下面" >> $dockerfile
	echo "RUN mkdir -p /var/lock/apache2 && mkdir -p /app && rm -rf /var/www/html && ln -s /app /var/www/html" >> $dockerfile  
	echo "COPY sample/ /app" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "#设置 apache 相关的一些变量，在容器启动的时候可以使用 -e 参数替代" >> $dockerfile
	echo "ENV APACHE_RUN_USER www-data" >> $dockerfile
	echo "ENV APACHE_RUN_GROUP www-data" >> $dockerfile
	echo "ENV APACHE_LOG_DIR /var/log/apache2" >> $dockerfile
	echo "ENV APACHE_PID_FILE /var/run/apache2.pid" >> $dockerfile
	echo "ENV APACHE_RUN_DIR /var/run/apache2" >> $dockerfile
	echo "ENV APACHE_LOCK_DIR /var/lock/apache2" >> $dockerfile
	echo "ENV APACHE_SERVERADMIN admin@localhost" >> $dockerfile
	echo "ENV APACHE_SERVERNAME localhost" >> $dockerfile
	echo "ENV APACHE_SERVERALIAS docker.localhost" >> $dockerfile
	echo "ENV APACHE_DOCUMENTROOT /var/www" >> $dockerfile
	echo -e "\n\r" >> $dockerfile
	
	echo "EXPOSE 80" >> $dockerfile
	echo "WORKDIR /app" >> $dockerfile
	echo "CMD ["/run.sh"]" >> $dockerfile
	
	echo "Write content to Dockerfile success !"
}

#写入内容到 run.sh，index.html 文件中
function write_file(){
	#写入内容到 run.sh
	echo "#!/bin/bash" > $run_sh
	echo "exec apache2 -D FOREGROUNP" >> $run_sh
	echo "Write content to run.sh success !"
	
	#写入内容到 index.html
	echo "<!DOCTYPE html>" > $index_page
	echo "<html>" >> $index_page
	echo -e "\t<body>" >> $index_page
	echo -e "\t\t<p>Hello, Docker!</p>" >> $index_page
	echo -e "\t</body>" >> $index_page
	echo "</html>" >> $index_page
	echo "Write content to index.html success !"
}

#创建镜像
function create_image(){
	docker build -t apache:ubuntu .
	if test $? -eq 0;then 
		echo "Create apache:ubuntu image success !";
	else
		echo "Create apache:ubuntu image failed !";
		exit 1
	fi
	
	
}

#测试镜像，运行容器
function run_container(){
	#判断镜像是否创建成功，这里通过创建的数量来确定，然后运行容器
	if [ $(docker images | grep -c "apache") -eq 1 ];then 
		docker run -d -P --name apache-server apache:ubuntu
		echo "Inspect image file , start container ！"
	else
		echo "Can't find the image to start container , start container failed !"
		exit 1
	fi
	#查看容器是否启动
	if [ $(docker ps | grep -c "apache-server") -eq 1 ];then echo "Contain is runing !";fi
}

#删除创建的文件
function delete_file(){
	if test -d $dockerfile_parent_folder
	then
		rm -rf $dockerfile_parent_folder
		echo "Delete folder success !"
		return $?
	else
		echo "Folder is not exist !"
		return $?
	fi
}

#test 
if test $command -eq 0
then 
	echo "Test success !"

#create file	
elif test $command -eq 1
then
	if test -d $docker_root_folder
	then
		create_file
		write_Dockerfile
		write_file
		create_image
		run_container		
		echo $?
	else
		mkdir -p $docker_root_folder
		echo "Creat folder 'docker' success!"
		create_file
		write_Dockerfile
		write_file
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