#!/bin/bash
#author:blood-elf  
#注：使用 $ nohup sh Oracle-Shell-Model.sh &   方式在后台执行,会在该目录下生成一个nohup.out 文件

#输入Oracle数据库的用户名密码等信息  username/password@ip:port/sid    username/password@sid
DBINFO="ecmp/ecmp@ecmp"
Sql_file_path="/home/sql"

echo "是否确定导入数据，确认将自动化执行脚本(y/n):"
read command

if test $command -eq 'y'
then

#导入数据  sqlplus -S 表示设置无提示模式， 该模式隐藏命令的 SQL*Plus 标帜，提示和回显的显示。
sqlplus -s ecmp/ecmp@ecmp  << ！ 
	#注：该句在SQLplus下表示打印SQL语句的执行时间
	set timming on;   	
	
	#表示sql脚本在执行的过程中如果有一个错误就会退出当前脚本;
	#DROP TABLE TBNAME; 如果表TBNAME不存在，则DROP 就会报错，而实际上这是正常的错误，我们还是希望脚本正常的往下执行，所以我们需要把 whenever sqlerror exit 1; 这句话删除掉，程序就能往下执行了，当然需要根据自身需要选择添加。
	whenever oserror exit 1;
	whenever sqlerror exit 1;
	
	#你想要执行的SQL文本
	@${Sql_file_path}/initTable.sql
	@${Sql_file_path}/initTable2.sql

	quit
!
	
	
else
	echo "自动化脚本退出!"
	exit 1
fi



