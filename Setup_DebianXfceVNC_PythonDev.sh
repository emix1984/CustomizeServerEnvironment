#!/bin/bash
# docker镜像要求：consol/debian-xfce-vnc
# 作者：Emix1984
# 日期：2025/1/16

# 定义函数模块
function update_system_packages() {
    echo ">>> 1.更新系统包管理清单"
    apt update && apt upgrade -y && apt autoremove -y
}

function install_common_packages() {
    echo ">>> 2.安装终端系统常用软件包"
    apt-get -y install git curl nano tree unzip net-tools screen
}

function install_python_dev_packages() {
    echo ">>> 3.安装python开发包"
    apt-get -y install openssl build-essential libssl-dev libffi-dev python3 python3-dev python3-pip python3-venv
}

function install_chromium_driver() {
    echo ">>> Option: 是否安装chromium-driver开发包？(y/n)"
    read choice
    if [[ "$choice" == "y" ]]; then
        echo "安装chromium-driver开发包"
        apt-get -y install chromium chromium-driver
    else
        echo "跳过安装chromium-driver开发包"
    fi
}

function install_desktop_packages() {
    echo ">>> Option: 是否安装系统桌面用软件包 - 可选？(y/n)"
    read choice
    if [[ "$choice" == "y" ]]; then
        echo "安装系统桌面用软件包 - 可选"
        apt-get -y install gedit gdebi
    else
        echo "跳过安装系统桌面用软件包"
    fi
}

function clean_system() {
    echo "**** 清理缓存和临时文件 ****"
    apt-get clean -y
    rm -rf /var/cache/apt/archives/*
}

# 主执行流程
echo ">>> 配置Python开发环境 - 配置脚本开始执行"
update_system_packages
install_common_packages
install_python_dev_packages
install_chromium_driver
install_desktop_packages
clean_system

echo "脚本执行完毕"
