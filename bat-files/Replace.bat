@echo off
title $$$$*blood-elf*$$$$

if exist settings.xml ( 
	copy settings.xml ..\.. 
	echo file copy success !
) else ( 
	echo settings.xml file is not exist !
)

pause
