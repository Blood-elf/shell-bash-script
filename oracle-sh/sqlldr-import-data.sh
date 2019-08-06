#!/bin/bash

echo "pleas input oracle user/pwd:"
read user_pwd

echo "pleas input date menu:"
read date_menu

echo "pleas input ctl filename:"
read ctl_filename

echo "pleas input data filename:"
read data_filename

echo "please choose host:(1:omp 2:oracle)"
read host

if test $host -eq 1
then
	root_path=/home/omp/datas
else
	root_path=/home/oracle/datas
fi


echo "exec command:"
echo "sqlldr $user_pwd control=$root_path/ctls/$ctl_filename log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/$data_filename"

sqlldr $user_pwd control=$root_path/ctls/$ctl_filename log=$root_path/logs/$date_menu/loadlog.txt bad=$root_path/bad/$date_menu/bad.txt data=$root_path/del/$date_menu/$data_filename