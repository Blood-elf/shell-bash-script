#!/bin/bash
cat nodes | while read line
do
	ip=`echo $line|awk '{print $1}'`
	sysName=`echo $line|awk '{print $2}'`
	path=`echo $line|awk '{print $3}'`
	UName=`echo $line|awk '{print $4}'`
	UPasswd=`echo $line|awk '{print $5}'`
	LPath=`pwd`
	if test "$sysName" = "Linux"
	then
	/usr/bin/expect  << EOF
	spawn scp $LPath/nmon_Linux  $UName@$ip:$path
	set timeout 50
	 expect {
        "*yes/no" { send "yes\r"; exp_continue }
        "*Password:" { send "$UPasswd\r" }
        }
	expect eof

	spawn ssh $UName@$ip
	set timeout 50
        expect {
        "*yes/no" { send "yes\r"; exp_continue }
        "*Password:" { send "$UPasswd\r" }
        }
	expect "*>"
        send "chmod 755 nmon_Linux\r"
        exit
        expect eof
EOF
fi
done
