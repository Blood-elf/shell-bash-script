#!/bin/bash
echo "Pls input fileName(-F):"
read fn
mkdir $fn
LPath=`pwd`
cd $fn

cat $LPath/nodes |while read line
do
	ip=`echo $line|awk '{print $1}'`
	UName=`echo $line|awk '{print $4}'`
	sysName=`echo $line|awk '{print $2}'`
	path=`echo $line|awk '{print $3}'`
	UPasswd=`echo $line|awk '{print $5}'`
	fileName=${ip}_$fn.nmon
	
	if test "$sysName" = "Linux"
	then
	/usr/bin/expect   << EOF
	spawn sftp $UName@$ip
	set timeout 50
	expect {
	"*Password:" {send "$UPasswd\r"}
	}
	expect "*>"
	set timeout 50
	send "get $path/$fileName\r"
	expect "*>"
        set timeout 50
	send "pwd\r"
	exit
	expect eof
EOF
	else
	/usr/bin/expect   << EOF
	spawn sftp $UName@$ip
	set timeout 50
	expect {
	"*password:" {send "$UPasswd\r\n"}
	}
	expect "*>"
	set timeout 50
	send "get $path/$fileName\r\n"
	expect "*>"
	set timeout 50
	exit
	expect eof
EOF
fi
done
