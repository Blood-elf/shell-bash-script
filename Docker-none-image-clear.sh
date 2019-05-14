#!/bin/bash

echo "please input command num : 0 test,1 stop container,2 rm container,3 rmi none images,4 all-execute,quite <Ctrl + D>"

while read command
do

	#测试指令
	if test $command -eq 0
	then
		echo "Test command success !" 

	#批量停止容器指令
	elif test $command -eq 1
	then
		docker ps -a | grep "Exited" | awk '{print $1}' |xargs docker stop
		echo " ****************** command-1.Stop container success ****************** !"
		
	#批量删除退出容器指令
	elif test $command -eq 2
	then
		docker ps -a | grep "Exited" | awk '{print $1}' |xargs docker rm
		echo " ****************** command-2.Delete container success ****************** !"
		
	#批量删除版本标签为none的镜像
	elif test $command -eq 3
	then
		docker images | grep none | awk '{print $3}' |xargs docker rmi
		echo " ****************** command-3.Delete none images success ****************** !"

	elif test $command -eq 4
	then 
		docker ps -a | grep "Exited" | awk '{print $1}' |xargs docker stop
		echo " ****************** command-4.Stop container success ****************** !"
		docker ps -a | grep "Exited" | awk '{print $1}' |xargs docker rm
		echo " ****************** command-4.Delete container success ****************** !"
		docker images | grep none | awk '{print $3}' |xargs docker rmi
		echo " ****************** command-4.Delete none images success ****************** !"

	else
		echo " ****************** command num is error ! ****************** "
	fi
	
	echo "please input command num : 0 test,1 stop container,2 rm container,3 rmi none images,4 all-execute,quite <Ctrl + D>"
	
done

