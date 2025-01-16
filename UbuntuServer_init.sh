#!/bin/bash

# 打印信息函数
print_info() {
    echo "[INFO] $1"
}

# 打印错误函数
print_error() {
    echo "[ERROR] $1"
}

# 检查命令是否成功执行的函数
check_command() {
    if [ $? -ne 0 ]; then
        print_error "$1"
        exit 1
    else
        print_info "$2"
    fi
}

# 更新和升级系统
update_upgrade_system() {
    print_info "正在更新和升级系统..."
    apt update && apt upgrade -y
    check_command "系统更新和升级失败" "系统更新和升级成功"
}

# 安装通用工具
install_common_tools() {
    print_info "正在安装通用工具..."
    apt install -y curl nano tree net-tools screen ntp traceroute htop sshpass
    check_command "安装通用工具失败" "通用工具安装成功"
}

# 同步时区
sync_timezone() {
    print_info "正在将时区同步为首尔..."
    timedatectl set-timezone Asia/Seoul
    check_command "设置时区失败" "时区设置为首尔成功"
    print_info "正在启动并启用NTP服务..."
    systemctl start ntp && systemctl enable ntp
    check_command "启动和启用NTP服务失败" "NTP服务启动和启用成功"
}

# 安装 ssh-copy-id
install_ssh_copy_id() {
    print_info "正在安装 ssh-copy-id..."
    apt install -y openssh-client
    check_command "安装 ssh-copy-id 失败" "ssh-copy-id 安装成功"
}

# 安装和配置OpenSSH服务
install_and_configure_ssh() {
    print_info "正在安装openssh-server和sudo..."
    apt update && apt install -y openssh-server sudo
    check_command "安装openssh-server和sudo失败" "openssh-server和sudo安装成功"
    print_info "正在启动openssh-server..."
    service ssh start
    check_command "启动openssh-server失败" "openssh-server启动成功"
    print_info "正在配置SSH以允许root登录..."
    if [ -f /etc/ssh/sshd_config ]; then
        # 备份原始配置文件
        cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
        echo "PasswordAuthentication yes" | tee -a /etc/ssh/sshd_config
        echo "PermitRootLogin yes" | tee -a /etc/ssh/sshd_config
        service sshd restart
        check_command "配置SSH失败" "SSH配置为允许root登录成功"
    else
        print_error "/etc/ssh/sshd_config文件未找到"
        exit 1
    fi
}

# 安装CasaOS
install_casaos() {
    print_info "正在安装CasaOS..."
    curl -fsSL https://get.casaos.io | bash
    check_command "安装CasaOS失败" "CasaOS安装成功"
}

# 主函数，按顺序调用各个模块
main() {
    update_upgrade_system
    install_common_tools
    sync_timezone
    install_ssh_copy_id
    install_and_configure_ssh
    install_casaos
    print_info "初始化配置完成"
}

# 执行主函数
main
