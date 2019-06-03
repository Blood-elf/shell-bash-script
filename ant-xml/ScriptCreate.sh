#!/bin/bash
#author:blood-elf
#url:https://github.com/Blood-elf

#输出脚本文件名，和 进程 PID
echo "$0 is running! PID : $$"

#需要创建的 ant 脚本文件名称  根据实际情况修改值
build_merge_xml=build-merge.xml
#版本  根据实际情况修改值
version=1.0.0
#target 工程名,根据项目名称来定义  根据实际情况修改值
project_name=test
#定义需要同步项目根目录前缀，通过该数据控制脚本可以处理的文件夹对象  根据实际情况修改值
project_prefix=(img js ecmp aaa bbb)

#对脚本文件进行内容写入
function write_build_xml(){
	echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>" > $build_merge_xml
	echo -e "\t<project name=\"test\" basedir=\".\" default=\"build\" xmlns:artifact=\"antlib:org.apache.maven.artifact.ant\">" >> $build_merge_xml
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 工程根目录 -->" >> $build_merge_xml
	#指定工程根目录
	echo -e "\t<property name=\"project\" value=\".\" />" >> $build_merge_xml
	#指定工程名
	echo -e "\t<property name=\"project.name\" value=\"$project_name\" />" >> $build_merge_xml
	#指定拷贝dest位置
	echo -e "\t<property name=\"target\" value=\"\${project}/../\${project.name}\" />" >> $build_merge_xml
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 版本 -->" >> $build_merge_xml
	echo -e "\t<property name=\"version\" value=\"$version\" />" >> $build_merge_xml
	
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 定义 代码源目录 -->" >> $build_merge_xml
	for file in `ls`
	do	
		f=`echo $file | awk -F- '{print $1}'`   #获取文件名的前缀根据 - 来进行分隔
		flag=`echo "${project_prefix[@]}" | grep -wq "$f" &&  echo 1 || echo 0` 
		if test $flag -eq 1
		then
			if test -d $file 
			then
				echo -e "\t<property name=\"module-${file}\" value=\"\${project}/../${file}\" />" >> $build_merge_xml
			fi
		fi
	done
	
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 定义 代码目标目录 -->" >> $build_merge_xml
	for file in `ls`
	do
		f=`echo $file | awk -F- '{print $1}'`
		flag=`echo "${project_prefix[@]}" | grep -wq "$f" &&  echo 1 || echo 0`
		if test $flag -eq 1
		then
			if test -d $file
			then
				echo -e "\t<property name=\"target-${file}\" value=\"\${target}/${file}\" />" >> $build_merge_xml
			fi
		fi
	done
	
	#拷贝资源文件
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<target name=\"code-copy\">" >> $build_merge_xml
	
	echo -e "\t\t<!-- 模式集合:忽略 文件夹 src/test/,.settings/,/target/, 和文件 .classpath,.project -->" >> $build_merge_xml
	echo -e "\t\t<patternset id=\"project.common.excludes\"  includes=\"**/*.*\" excludes=\"src/test/,.settings/,/target/,.classpath,.project\"/>" >> $build_merge_xml
	echo -e "\t\t<!-- 复制 cboms 资源文件 -->" >> $build_merge_xml
	for file in `ls`
	do
		f=`echo $file | awk -F- '{print $1}'`
		flag=`echo "${project_prefix[@]}" | grep -wq "$f" &&  echo 1 || echo 0` 
		if test $flag -eq 1
		then
			if test -d $file
			then
			echo -e "\t\t<copy todir=\"\${target-$file}\">" >> $build_merge_xml
				echo -e "\t\t\t<fileset dir=\"\${module-$file}\"  casesensitive=\"yes\">" >> $build_merge_xml
					echo -e "\t\t\t\t<patternset refid=\"project.common.excludes\" />" >> $build_merge_xml
				echo -e "\t\t\t</fileset>" >> $build_merge_xml
			echo -e "\t\t</copy>" >> $build_merge_xml			
			fi
		fi
	done
	echo -e "\t</target>" >> $build_merge_xml
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 准备 -->" >> $build_merge_xml
	echo -e "\t<target name=\"init\">" >> $build_merge_xml
	echo -e	"\t\t<mkdir dir=\"\${target}\" />" >> $build_merge_xml
	for file in `ls`
	do
		f=`echo $file | awk -F- '{print $1}'`
		flag=`echo "${project_prefix[@]}" | grep -wq "$f" &&  echo 1 || echo 0` 
		if test $flag -eq 1
		then
			if test -d $file
			then
				echo -e "\t\t<mkdir dir=\"\${target-$file}\" />" >> $build_merge_xml
			fi
		fi
	done
	echo -e "\t</target>" >> $build_merge_xml
	
	echo -e "\n\r" >> $build_merge_xml
	echo -e "\t<!-- 入\t口 -->" >> $build_merge_xml
	echo -e "\t<target name=\"build\">" >> $build_merge_xml
	echo -e	"\t\t<antcall target=\"init\" />" >> $build_merge_xml
	echo -e "\t\t<antcall target=\"code-copy\" />" >> $build_merge_xml
	echo -e "\t</target>" >> $build_merge_xml
	
	echo -e "\n\r" >> $build_merge_xml
	echo "</project>" >> $build_merge_xml
	
	echo "write file success!"
}

write_build_xml