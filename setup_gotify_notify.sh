#!/bin/bash

# 交互式输入
read -rp "请输入 Gotify 服务器地址（如 https://gotify.example.com）： " GOTIFY_URL
read -rp "请输入 Gotify Token： " GOTIFY_TOKEN
read -rp "请输入服务器名称（server_name）： " SERVER_NAME

LOCAL_SCRIPT_PATH="/opt/gotify_startup_notify.sh"

# 生成 gotify_startup_notify.sh 脚本
cat > "$LOCAL_SCRIPT_PATH" <<EOF
#!/bin/bash
curl -X POST "\${GOTIFY_URL}/message?token=\${GOTIFY_TOKEN}" \\
    -F "title=服务器启动通知" \\
    -F "message=服务器 [ \${SERVER_NAME} ] 已启动" \\
    -F "priority=5"
EOF

# 用变量值替换脚本中的变量
sed -i "s#\${GOTIFY_URL}#${GOTIFY_URL}#g" "$LOCAL_SCRIPT_PATH"
sed -i "s#\${GOTIFY_TOKEN}#${GOTIFY_TOKEN}#g" "$LOCAL_SCRIPT_PATH"
sed -i "s#\${SERVER_NAME}#${SERVER_NAME}#g" "$LOCAL_SCRIPT_PATH"

chmod +x "$LOCAL_SCRIPT_PATH"

# 配置 systemd 服务
SERVICE_FILE="/etc/systemd/system/gotify-notify.service"

cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Gotify Startup Notification
After=network.target

[Service]
ExecStart=$LOCAL_SCRIPT_PATH
Type=oneshot

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable gotify-notify.service

echo "脚本已成功配置为开机自动执行。"