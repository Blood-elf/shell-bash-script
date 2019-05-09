#!/bin/bash
# author:Blood-elf

echo "$0 is running!"

path_docker=/home/docker
path_file=/home/docker/sshd_ubuntu
dockerfile=Dockerfile
run_sh=run.sh

echo "pleas input command : 0 test，1 create,2 delete"
read command

function create_file(){
	mkdir $path_file
	cd $path_file
	touch $dockerfile $run_sh
	chmod +x $run_sh
	return "Create file success!"	
}

function delete_file(){
	if test -d $path_docker
	then
		rm -rf $path_docker
		return "Delete folder success !"
	else
		return "Folder is not exist !"
	fi
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



