@echo off

color 03

:go

set /p srcfolder=please input source folder name:

set /p resultfile=please input result file name:

set /p startline=please input start line:

set /p destfile=please input end line:

rem java -jar XSLXFileUtil.jar files test10 30 300
rem jdk version:1.7  srcfolder路径若包含空格，需要将路径用引号包裹
java -jar XSLXFileUtil.jar %srcfolder% %resultfile% %startline% %destfile%

echo success!

goto go

pause