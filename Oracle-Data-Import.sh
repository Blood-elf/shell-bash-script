#!/bin/bash
#author:blood-elf  
#https://blog.csdn.net/three_j/article/details/84927958
#http://f.dataguru.cn/thread-855797-1-1.html
#https://www.cnblogs.com/cuker919/p/4878516.html
#https://blog.csdn.net/hj402555749/article/details/7328508

#输入Oracle数据库的用户名密码等信息
DBINFO="ecmp/ecmp@ecmp"

echo "是否确定导入数据，确认将自动化执行脚本(y/n):"
read command

if test $command -eq 'y'
then

#导入数据  sqlplus -S 表示设置无提示模式， 该模式隐藏命令的 SQL*Plus 标帜，提示和回显的显示。
sqlplus -s ecmp/ecmp@ecmp  << ！ 
	
！ 
	
	
else
	echo "自动化脚本退出!"
	exit 1
fi
