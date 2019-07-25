#!/bin/bash
echo "Pls input stop nmon file name(-F):"
read fn
cat nodes |while read line
do
	ip=`echo $line|awk '{print $1}'`
	UName=`echo $line|awk '{print $4}'`
	sysName=`echo $line|awk '{print $2}'`
	path=`echo $line|awk '{print $3}'`
	UPasswd=`echo $line|awk '{print $5}'`
	nmonName="ps -ef | grep nmon |grep -v grep | grep -i $fn | awk '{print \\\$2}' | xargs kill -9"

	if test "$sysName" = "Linux"
	then
	/usr/bin/expect << EOF
	spawn ssh $UName@$ip
	set timeout 10
	expect {
	"*yes/no" {send "yes\r"; exp_contiune}
	"*Password:" {send "$UPasswd\r"}
	}
	expect "*>"
	set timeout 10
#	send "ps -ef | grep nmon |grep -v grep | grep -v \\\$fn | awk '{print \\\$2}' | xargs kill -9\r"
	send "$nmonName\r" 
	expect "*>"
        set timeout 10
	send "pwd\r"
	interact
	exit
	expect eof
EOF
	else
	/usr/bin/expect << EOF
	spawn ssh $UName@$ip
	set timeout 10
	expect {
#	"*yes/no" {send "yes\r"; exp_contiune}
	"*password:" {send "$UPasswd\r"}
	}
	expect "*>"
	set timeout 10
	send "ps -ef | grep nmon |grep -v grep | awk '{print \\\$2}' | xargs kill -9\r"
	expect "*>"
        set timeout 10
#	send "pwd\r"
#	interact
	exit
	expect eof
EOF
fi
done
