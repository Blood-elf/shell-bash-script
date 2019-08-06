#!/bin/bash
#author zh

#传入参数判断
if test $# -ne 2;then
	echo "USAGE : sh omp_depre.sh  SYS YYYYMMDD"  #SYS:数据源系统 YYYYMMDD:传输日期
	exit 1
else
 pre=OMP
 host=omp
 sys=${1}
 dl=${2}
 echo "pre=${pre},sys=${sys},dl=${dl}"		
fi


#数据存放根目录 /home/omp/datas
ddath=/home/$host/datas
echo ${ddath}

#创建解压数据存放文件夹 /home/omp/datas/del
dpath_del=${ddath}/del/${dl}
if test ! -d $dpath_del ; then
	mkdir -p ${dpath_del}
fi

#创建日志存放文件夹 /home/omp/datas/logs
dpath_log=${ddath}/logs/${dl}
if test ! -d $dpath_log ; then
	mkdir -p ${dpath_log}
fi

#创建错误文件存放文件夹 //home/omp/datas/bad
dpath_bad=${ddath}/bad/${dl}
if test ! -d $dpath_bad ; then
	mkdir -p ${dpath_bad}
fi

#解压文件到 del/2019xxxx 文件夹下
tar -xzvf $ddath/${pre}_${sys}_${dl}.tar.gz -C $ddath/del/$dl/;
echo "exec tar ${ddath}/${dl}/${pre}_${sys}_${dl}.tar.gz"

returnval=$?
if test ${returnval} -ne 0 ; then
   echo "decompress file : ${ddath}/${1}/${pre}_${sys}_${dl}.tar.gz  failed !"
   exit 1
else
   echo "decompress file ：${ddath}/${1}/${pre}_${sys}_${dl}.tar.gz  success ！"
fi

#清理之前的数据文件，查找更改时间在20天以前的文件并删除
find $ddath/del/ -name "*.del" -type f -mtime +20 -exec rm -rf {} \;


