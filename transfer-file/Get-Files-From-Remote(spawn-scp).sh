#!/bin/bash

UName=omp
UPasswd=omp
ip=66.6.53.56
path=/home/omp/datas
target=/home/oracle


SysType=`uname -s`
echo SysType:$SysType

if test $SysType = "Linux"
then
	/usr/bin/expect   << EOF
	spawn scp -r $UName@$ip:$path $target
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