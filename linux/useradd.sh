#!/bin/bash

#创建用户was 该方法可以在创建用户时制定该用户的根路径和密码。
useradd -d /home/was -m was

#设置was用户密码
passwd was

#赋予部分特殊权限
chown -R was /opt/IBM/WebSphere/AppServer/profiles

#创建组 groupadd cdadmin 或 mkgroup cdadmin
groupadd cdadmin 

#改变用户所属组


