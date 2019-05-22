@echo off

setlocal enabledelayedexpansion
set classpath=.
for %%c in (lib\*) do set classpath=!classpath!;%%c

set classpath=%classpath%;config;

java -cp %CLASSPATH% -Dfile.encoding=utf-8 com.geor.gcr.vfs.ExcelVfsBatchRunner %1 %2
pause