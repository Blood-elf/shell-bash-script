#!/bin/bash
#author:blood-elf

#解压安装包存放的位置
dest_path=/usr/local/
#环境变量文件
env_file=/etc/profile
#环境变量文件备份位置
env_file_bank=/home/mj/

echo "请输入解压 jdk 包名："
read jdk_tar

#解压文件到指定的位置
tar zxvf ./$jdk_tar $dest_path

#备份系统环境变量
cp $env_file $env_file_bank

#编辑系统环境变量
echo -e "\n\r" >> $env_file
echo "export JAVA_HOME=/usr/local/jdk1.8.0_181" >> $env_file
echo "export JRE_HOME=/usr/local/jdk1.8.0_181/jre" >> $env_file
echo "export CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib" >> $env_file
echo "export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin" >> $env_file

#重新加载配置文件
source /etc/profile

#java版本
java_version=`java -version`
echo $java_version


