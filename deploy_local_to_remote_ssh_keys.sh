#!/bin/bash

# 远程服务器的 IP 地址或主机名
REMOTE_HOST="your_remote_host_ip_or_hostname"
# 远程服务器的用户名（根据需要修改）
REMOTE_USER="root"
# 远程服务器的 SSH 端口（如果不是默认的 22 端口，请修改为实际端口）
REMOTE_PORT="22"  # 修改为实际端口号

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

# 模块：生成本地 SSH 密钥对
module_generate_ssh_key() {
    print_info "正在生成本地 SSH 密钥对..."
    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
        check_command "生成 SSH 密钥对失败" "SSH 密钥对生成成功"
    else
        print_info "本地 SSH 密钥对已存在，跳过生成步骤"
    fi
}

# 模块：将本地公钥复制到远程服务器
module_copy_public_key() {
    print_info "正在将本地公钥复制到远程服务器..."
    ssh-copy-id -i ~/.ssh/id_rsa.pub -p ${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST}
    check_command "复制公钥到远程服务器失败" "公钥已成功复制到远程服务器"
}

# 模块：测试免密码登录
module_test_passwordless_login() {
    print_info "正在测试免密码登录远程服务器..."
    ssh -o BatchMode=yes -o ConnectTimeout=10 -p ${REMOTE_PORT} ${REMOTE_USER}@${REMOTE_HOST} "echo '免密码登录成功'"
    if [ $? -eq 0 ]; then
        print_info "免密码登录测试成功"
    else
        print_error "免密码登录测试失败，请检查配置"
    fi
}

# 主函数，按顺序调用各个模块
main() {
    module_generate_ssh_key
    module_copy_public_key
    module_test_passwordless_login
    print_info "本地免密码登录远程服务器配置完成"
}

# 执行主函数
main
