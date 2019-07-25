#!/bin/bash
echo "pls input collection frequency(-S):"
read sec
echo "Pls input collection number(-C):"
read cout
echo "Pls input fileName(-F):"
read fn

cat nodes |while read line
do
	ip=`echo $line|awk '{print $1}'`
	UName=`echo $line|awk '{print $4}'`
	path=`echo $line|awk '{print $3}'`
	sysName=`echo $line|awk '{print $2}'`
	UPasswd=`echo $line|awk '{print $5}'`
#	LocalIP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
	fileName=${ip}_$fn.nmon
	
	if test "$sysName" = "Linux"
	then
	/usr/bin/expect << EOF
	spawn ssh $UName@$ip
	set timeout 3
	expect {
#	"*yes/no" {send "yes\r"; exp_contiune}
	"*Password:" {send "$UPasswd\r"}
	}
	expect "*>"
	set timeout 3
	send "$path/nmon_Linux -s $sec -c $cout -F $path/$fileName -t\r"
	expect "*>"
        set timeout 3
	send "pwd\r"
	exit
	expect eof
EOF
	else
	/usr/bin/expect << EOF
	spawn ssh $UName@$ip
	set timeout 3
	expect {
	"*password:" {send "$UPasswd\r"}
	}
	send "/usr/bin/nmon -s $sec -c $cout -F $path/$fileName -t\r"
	expect "*>"
	set timeout 3
	exit
EOF
fi
done
