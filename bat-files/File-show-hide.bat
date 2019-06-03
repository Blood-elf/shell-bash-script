@echo off
color 0d
title $***blood-elf***$

cd /d E:\迅雷下载

set /p var=please input a number ; 0 test,1 hide,2 show:

if %var% equ 0 (
	echo no task!
)

if %var% equ 1 (
	attrib +s +a +h +r file
	echo "Hide file succesful !"
)

if %var% equ 2 (
	attrib -s -a -h -r file
	echo "Show file folder successful !"
)

exit
