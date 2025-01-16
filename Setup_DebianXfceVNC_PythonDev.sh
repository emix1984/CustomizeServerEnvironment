#!/bin/bash
# docker镜像要求：consol/debian-xfce-vnc
# 作者：Emix1984
# 日期：2025/1/16

echo ">>> 配置Python开发环境 - 配置脚本开始执行"

# 更新系统软件包列表
echo "1.更新系统包管理清单"
apt update && clear

# 安装其他必要的软件包，如git curl nano net-tools
echo "2.安装终端系统常用软件包"
apt-get -y install git curl nano tree unzip net-tools screen

# 安装必要的Python开发环境软件包
echo "3.安装python开发包"
apt-get -y install openssl build-essential libssl-dev libffi-dev python3 python3-dev python3-pip python3-venv

# 交互式选择是否安装chromium-driver开发包
echo "4.是否安装chromium-driver开发包？(y/n)"
read choice
if [ "$choice" = "y" ]; then
    echo "安装chromium-driver开发包"
    apt-get -y install chromium chromium-driver
else
    echo "跳过安装chromium-driver开发包"
fi

# 交互式选择是否安装系统桌面用软件包
echo "5.是否安装系统桌面用软件包 - 可选？(y/n)"
read choice
if [ "$choice" = "y" ]; then
    echo "安装系统桌面用软件包 - 可选"
    apt-get -y install gedit gdebi
else
    echo "跳过安装系统桌面用软件包"
fi

# 清理缓存和临时文件
echo "**** 清理缓存和临时文件 ****"
apt-get clean -y
rm -rf /var/cache/* /tmp/*

echo "脚本执行完毕"
