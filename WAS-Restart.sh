#!/bin/bash
#author:blood-elf

#dmgr 路径、名称
dmgr_file="dmgr.pid"
dmgr_pid=/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/logs/dmgr/dmgr.pid

#nodeagent 路径、名称
node_file="nodeagent.pid"
node_pid=/opt/IBM/WebSphere/AppServer/profiles/Custom72/logs/nodeagent/nodeagent.pid

#server 路径、名称
server_file="EcmpServer72.pid"
server_pid=/opt/IBM/WebSphere/AppServer/profiles/Custom72/logs/EcmpServer72/EcmpServer72.pid

#dmgr 启动文件位置
startManager=/opt/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/startManager.sh

#node 启动文件位置
startNode=/opt/IBM/WebSphere/AppServer/profiles/Custom72/bin/startNode.sh

pid_file=
pid_file_name=
start_file=

#停止进程
function stop(){
	if test -f $pid_file
	then
		pid=`more $pid_file`
		kill -9 $pid
		echo "kill => $pid_file_name : $pid"
	else
		echo "$pid_file_name is not exits !"
	fi
	
	return $?
}

#启动was服务器
function start(){
	if test -f $start_file
	then
		sh $start_file
		echo "server start success !"
	else
		echo "server start failured !"
	fi
	
	return $?
}

while true
do

	echo "please choice command : 0 test,1 stop all,2 stop node,3 restart all,4 restart node"
	read command

	#测试指令
	if test $command -eq 0
	then
		echo "test command execute success !"
		exit 1

	#停止管理概要、节点、服务器	
	elif test $command -eq 1
	then
		pid_file=`echo $dmgr_pid`
		pid_file_name=`echo $dmgr_file`
		stop
		pid_file=`echo $node_pid`
		pid_file_name=`echo $node_file`
		stop
		pid_file=`echo $server_pid`
		pid_file_name=`echo $server_file`
		stop
		exit 1

	#停止节点、服务器	
	elif test $command -eq 2
	then
		pid_file=`echo $node_pid`
		pid_file_name=`echo $node_file`
		stop
		pid_file=`echo $server_pid`
		pid_file_name=`echo $server_file`
		stop
		exit 1
	
	#启动管理概要、服务器节点
	elif test $command -eq 3
	then
		start_file=`echo $startManager`
		sh $start_file
		start_file=`echo $startNode`
		sh $start_file
	
	#启动服务器节点
	elif test $command -eq 4
	then
		start_file=`echo $startNode`
		sh $start_file
	
	else
		echo "invalid command!"
		
	fi

done


