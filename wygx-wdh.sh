. /home/db2icli/sqllib/db2profile
# �жϲ���
if [ $# -ne 1 ];then
 echo "������ʽ������������ȷ"
 echo " ��ȷ���ø�ʽ: *.ksh YYYYMMDD"
 exit 1
else
 etldt=${1}
 echo "etldt=${etldt}"
fi
#�����жϲ���

sdath=/gpfs/etl2/afa/${1}
ddath=/home/wygx

#��������
export DB2CODEPAGE=1386
db2 terminate
db2 connect to afa user jssjcx using jssjcx12;
db2 "export to ${ddath}/mid_svsysinfo${1}.del of del select * from afa.mid_svsysinfo"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "��afa�⵼��mid_svsysinfoʧ��fail"
   db2 terminate;
   exit 1
else
   echo "��afa�⵼��mid_svsysinfo�ɹ�success"
fi

db2 "export to ${ddath}/mid_sysinfo${1}.del of del select * from afa.mid_sysinfo"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "��afa�⵼��mid_sysinfoʧ��fail"
   db2 terminate;
   exit 1
else
   echo "��afa�⵼��mid_sysinfo�ɹ�success"
fi
db2 terminate;

#��������
export DB2CODEPAGE=1208
db2 terminate
db2 connect to ecip user wygx using wygx1234;
db2 "load client from ${ddath}/mid_svsysinfo${1}.del of DEL modified by CODEPAGE=1386 replace into netbank.mid_svsysinfo NONRECOVERABLE"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "����ECIP��mid_svsysinfo��ʧ��fail"
   db2 terminate;
   exit 1
else
   echo "����ECIP��mid_svsysinfo��ɹ�success"
fi

db2 "load client from ${ddath}/mid_sysinfo${1}.del of DEL modified by CODEPAGE=1386 replace into netbank.mid_sysinfo NONRECOVERABLE"
returnval=$?
if [ ${returnval} -ne 0 ]; then
   echo "����ECIP��mid_sysinfo��ʧ��fail"
   db2 terminate;
   exit 1
else
   echo "����ECIP��mid_sysinfo��ɹ�success"
fi
db2 terminate;


find $ddath -name "*.del" -type f -mtime +5 -exec rm -rf {} \;
 