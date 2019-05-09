. /home/db2icli/sqllib/db2profile
# 判断参数
if [ $# -ne 1 ];then
 echo "参数格式（个数）不正确"
 echo " 正确调用格式: *.ksh YYYYMMDD"
 exit 1
else
 etldt=${1}
 echo "etldt=${etldt}"
fi
#结束判断参数

sdath=/gpfs/etl2/afa/${1}
ddath=/home/wygx

#导出数据
export DB2CODEPAGE=1386
db2 terminate
db2 connect to afa user jssjcx using jssjcx12;
db2 "export to ${ddath}/mid_svsysinfo${1}.del of del select * from afa.mid_svsysinfo"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "从afa库导出mid_svsysinfo失败fail"
   db2 terminate;
   exit 1
else
   echo "从afa库导出mid_svsysinfo成功success"
fi

db2 "export to ${ddath}/mid_sysinfo${1}.del of del select * from afa.mid_sysinfo"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "从afa库导出mid_sysinfo失败fail"
   db2 terminate;
   exit 1
else
   echo "从afa库导出mid_sysinfo成功success"
fi
db2 terminate;

#导入数据
export DB2CODEPAGE=1208
db2 terminate
db2 connect to ecip user wygx using wygx1234;
db2 "load client from ${ddath}/mid_svsysinfo${1}.del of DEL modified by CODEPAGE=1386 replace into netbank.mid_svsysinfo NONRECOVERABLE"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "更新ECIP库mid_svsysinfo表失败fail"
   db2 terminate;
   exit 1
else
   echo "更新ECIP库mid_svsysinfo表成功success"
fi

db2 "load client from ${ddath}/mid_sysinfo${1}.del of DEL modified by CODEPAGE=1386 replace into netbank.mid_sysinfo NONRECOVERABLE"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "更新ECIP库mid_sysinfo表失败fail"
   db2 terminate;
   exit 1
else
   echo "更新ECIP库mid_sysinfo表成功success"
fi
db2 terminate;


find $ddath -name "*.del" -type f -mtime +5 -exec rm -rf {} \;
 