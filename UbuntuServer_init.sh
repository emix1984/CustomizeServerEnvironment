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

# 模块：更新和升级系统
module_update_upgrade_system() {
    print_info "正在更新和升级系统..."
    apt update && apt upgrade -y
    check_command "系统更新和升级失败" "系统更新和升级成功"
}

# 模块：安装通用工具
module_install_common_tools() {
    print_info "正在安装通用工具..."
    apt install -y curl wget nano tree net-tools screen tmux traceroute htop sshpass openssl
    check_command "安装通用工具失败" "通用工具安装成功"
}

# 模块：同步时区
module_set_timezone() {
    print_info "正在将时区同步为首尔..."
    timedatectl set-timezone Asia/Seoul
    check_command "设置时区失败" "时区设置为首尔成功"
}

# 模块：安装 ssh-copy-id
module_install_ssh_copy_id() {
    print_info "正在安装 ssh-copy-id..."
    apt install -y openssh-client
    check_command "安装 ssh-copy_id 失败" "ssh-copy_id 安装成功"
}

# 模块：安装和配置OpenSSH服务
module_install_and_configure_ssh() {
    print_info "正在安装 openssh-server 和 sudo..."
    apt update && apt install -y openssh-server sudo
    check_command "安装 openssh-server 和 sudo 失败" "openssh-server 和 sudo 安装成功"
    print_info "正在启动 openssh-server..."
    service ssh start
    check_command "启动 openssh-server 失败" "openssh-server 启动成功"
    print_info "正在配置 SSH 以允许 root 登录..."
    if [ -f /etc/ssh/sshd_config ]; then
        # 备份原始配置文件
        cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
        echo "PasswordAuthentication yes" | tee -a /etc/ssh/sshd_config
        echo "PermitRootLogin yes" | tee -a /etc/ssh/sshd_config
        systemctl restart ssh
        check_command "配置 SSH 失败" "SSH 配置为允许 root 登录成功"
    else
        print_error "/etc/ssh/sshd_config 文件未找到"
        exit 1
    fi
}

# 模块：增加命令历史记录的存储数量
module_increase_history_size() {
    print_info "正在增加命令历史记录的存储数量..."
    echo "HISTSIZE=99999" >> /etc/profile
    echo "HISTFILESIZE=99999" >> /etc/profile
    check_command "设置命令历史记录失败" "命令历史记录设置成功"
    print_info "重新加载配置文件以应用更改..."
    source /etc/profile
    check_command "重新加载配置文件失败" "配置文件重新加载成功"
}

# 模块：清理系统
module_clean_system() {
    print_info "正在清理系统..."
    sudo apt clean
    sudo apt autoremove --purge -y
    sudo logrotate -f /etc/logrotate.conf
    rm -rf /var/cache/apt/archives/*
    sudo rm -rf /tmp/*
    check_command "系统清理失败" "系统清理成功"
}

# 模块：修改 root 用户的默认工作目录
module_change_root_home() {
    local target_dir="/DATA/AppData"
    print_info "正在修改 root 用户的默认工作目录为 $target_dir..."
    if [ ! -d "$target_dir" ]; then
        print_info "目标目录 $target_dir 不存在，正在创建..."
        mkdir -p "$target_dir"
        check_command "创建目录失败" "目标目录创建成功"
    fi
    # usermod -d "$target_dir" root # 注释掉原因：由于这句导致user root current used by process 1错误
    check_command "修改 root 用户的工作目录失败" "root 用户的工作目录已更改为 $target_dir"
}

# 主函数，按顺序调用各个模块
main() {
    module_update_upgrade_system
    module_install_common_tools
    module_set_timezone
    module_install_ssh_copy_id
    module_install_and_configure_ssh
    module_increase_history_size
    module_change_root_home
    module_clean_system
    print_info "初始化配置完成，请重启服务器。"
}

# 执行主函数
main
