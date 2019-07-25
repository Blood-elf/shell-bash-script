@echo off

:: mode为模式，allow表示开启，disallow表示关闭；
:: ssid为wifi名称；
:: key为wifi密码。
:: 三个命令也可以独立使用。
netsh wlan set hostednetwork	mode=allow	ssid=bijibenwifi	key=12345678


::将Internet设置成共享模式;
::具体操作，先选中已经连接的网络，右键菜单，选择属性；在共享栏中勾选运行网络共享;

:wait
set /p model=please choose model , 1:wait 2:open wifi  3:stop wifi
if %model% equ 1 (
	goto wait
)
if %model% equ 2 (
	goto open
)
if %model% equ 3 (
	goto stop
)


:open
::打开无线网络;
netsh wlan start hostednetwork
goto wait

:stop
::将以上代码中的start改成stop即可关闭该网络;
netsh wlan stop hostednetwork
goto wait
