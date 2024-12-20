#!/bin/bash
# docker镜像要求：consol/debian-xfce-vnc
# 作者：Emix1984
# 日期：2024/12/06

echo ">>> 配置Python开发环境 - 配置脚本开始执行"

# 更新系统软件包列表
echo "1.更新系统包管理清单"
apt update


# 安装必要的Python开发环境软件包
echo "2.安装python开发包"
apt-get -y install openssl build-essential libssl-dev libffi-dev python3 python3-dev python3-pip python3-venv

# 安装Chromium浏览器和驱动，用于Web开发和测试
echo "3.安装chromium-driver开发包"
apt-get -y install chromium chromium-driver

# 安装其他必要的软件包，如gedit、gdebi、nano、unzip
echo "4.安装系统桌面用软件包 - 可选"
apt-get -y install gedit gdebi nano unzip

# 清理缓存和临时文件
echo "**** 清理缓存和临时文件 ****"
apt-get clean -y
rm -rf /var/cache/* /tmp/*

echo "脚本执行完毕"
