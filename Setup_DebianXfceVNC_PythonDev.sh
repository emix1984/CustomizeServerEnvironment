#!/bin/bash
# docker镜像要求：consol/debian-xfce-vnc:v2.0.3
# 作者：Emix1984
# 日期：2025/1/25

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

function install_desktop_packages() {
    echo ">>> 4.安装系统桌面用软件包"
    apt-get -y install gedit gdebi
}

function install_chromium_driver() {
    local choice
    while true; do
        echo ">>> Option: 是否安装chromium-driver开发包？(1: 安装, 2: 不安装)"
        read -r choice
        case "$choice" in
            1)
                echo "安装chromium-driver开发包"
                apt-get -y install chromium chromium-driver
                return 0  # 安装完成后继续执行后续脚本
                ;;
            2)
                echo "跳过安装chromium-driver开发包，继续执行后续步骤。"
                return 0  # 跳过安装，直接继续执行后续脚本
                ;;
            *)
                echo "输入错误，请输入1或2。"
                ;;
        esac
    done
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
install_desktop_packages
install_chromium_driver
clean_system

echo "脚本执行完毕"
