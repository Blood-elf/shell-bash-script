#!/bin/bash
#author:blood-elf

#解压安装包存放的位置
dest_path=/usr/local/
#环境变量文件
env_file=/etc/profile
#环境变量文件备份位置
env_file_bank=/home/mj/


echo "请输入解压 jdk 包名(注：jdk tar 文件需要与本脚本处于同一文件夹中)："
read jdk_tar

#判断需要解压的文件是否存在
if test ! -e ./$jdk_tar
then 
	echo "解压的文件不存在，请检查确保文件再合适的位置!"
	exit 1
fi


#解压文件到指定的位置
tar zxvf ./$jdk_tar -C $dest_path

#设置 jdk 主目录路径
jdk_folder=`find $dest_path -maxdepth 1 -name "*jdk" -type f |xargs ls`
JAVA_HOME=${dest_path}${jdk_folder}
echo "JAVA_HOME:${JAVA_HOME}"


#备份系统环境变量
cp $env_file $env_file_bank

#编辑系统环境变量
echo -e "\n\r" >> $env_file
echo "export JAVA_HOME=${JAVA_HOME}" >> $env_file
echo "export JRE_HOME=${JAVA_HOME}/jre" >> $env_file
echo "export CLASS_PATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JRE_HOME/lib" >> $env_file
echo "export PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin" >> $env_file

#重新加载配置文件
source /etc/profile

#java版本
java_version=`java -version`
echo $java_version




