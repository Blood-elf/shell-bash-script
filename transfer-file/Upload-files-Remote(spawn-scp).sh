#!/bin/bash
#author:blood-elf


echo "usage:xxx.sh username passwd ip target-folder"

# 判断参数
if test $# -eq  0
then
	UName=was
	UPasswd=was
	ip=66.6.55.132
	path=/e/scp-source/sharelib/
	#target=/home/was/home/
	target=/opt/IBM/WebSphere/AppServer/profiles/Custom01/installedApps/yes55suse12132Cell01/omp1_war.ear/omp.war/WEB-INF/classes
else
	UName=$1
	UPasswd=$2
	ip=$3
	target=$4
fi


SysType=`uname -s`
echo SysType:$SysType

#scp -r /e/scp-source/sharelib/ was@66.6.55.132:/home/was/home/ 
#scp  /e/scp-source/sharelib/xxx.txt was@66.6.55.132:/home/was/home/ 

if test $SysType = "Linux"
then
	/usr/bin/expect   << EOF
	spawn scp -r $path $UName@$ip:$target
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

sleep 5s