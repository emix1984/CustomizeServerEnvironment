#!/bin/bash
# 系统要求：ubuntu desktop 24.04
# 作者：Emix1984
# 日期：2024/12/06

# 更新系统软件包列表
echo "更新系统包管理清单..."
sudo apt update

# 安装OpenSSH服务器
echo "安装OpenSSH服务器..."
sudo apt install -y openssh-server

# 启用root账户
echo "启用root账户..."
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# 设置root账户密码（交互式）
echo "设置root账户密码..."
sudo passwd root

# 重新启动SSH服务以应用更改
echo "重新启动SSH服务..."
sudo systemctl restart ssh

echo "OpenSSH服务器安装并配置完成。"
