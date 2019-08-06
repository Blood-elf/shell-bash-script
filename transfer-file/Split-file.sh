#!/bin/bash   

echo "pleas input file name:"
read basename
echo "pleas input the line number:"
read sonfile_linenum

echo "basename:$basename,sonfile_linenum:$sonfile_linenum"

if test ! -e $basename
then
	echo file is not exit !
	sleep 5s	
	exit 1
fi

pre_name=`echo $basename | awk -F. '{print $1}'`
suffix_name=`echo $basename | awk -F. '{print $2}'`
src_tol_linenum=`wc -l $basename|   awk   '{print $1}'` 

#读数游标
course=1  
file_seq_num=1
line_num=`expr $sonfile_linenum - 1`
#创建分割文件存放目录
if test -d $pre_name
then
	rm -rf $pre_name
	mkdir $pre_name
else
	mkdir $pre_name
fi

#创建日志记录文件
if test -f $pre_name.txt
then
	rm -f $pre_name.txt
fi

function method-sed(){
  son_linenum=`expr $course + $line_num`
  echo "course：${course} ,end_course: ${son_linenum},src_tol_linenum:${src_tol_linenum},line_num:${line_num}" >> $pre_name.txt
  echo -e "\n\r" >> $pre_name.txt
  #nl $basename|sed   -n   "${course},${son_linenum}p" 
  sed -n "${course},${son_linenum}p" $basename >   $pre_name/${pre_name}_${file_seq_num}.${suffix_name} 
  course=`expr $son_linenum + 1`   
  file_seq_num=`expr $file_seq_num + 1`   
}
   
while [ $course -lt $src_tol_linenum ]   
do
	method-sed
done 

if test $? -eq 0
then
	echo "split file success ,program exit!"
fi


sleep 6s




 