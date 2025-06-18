used for preset Ubuntu Server
OS: Ubuntu Server 22.04 LTS (Jammy Jellyfish)

preset: openssh-server, CasaOS, Gotify

# 服务器初始化
## Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o ubuntuserver_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh

## Debian & Ubuntu Server with user-root install CasaOS
apt update && apt install -y curl && \
curl -fsSL -o ubuntuserver_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh casaos


## Deploy Local_Ubuntu_Server ssh keys to Remote_Ubuntu_Server
apt update && apt install -y curl && \
curl -fsSL -o deploy_local_to_remote_ssh_keys.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/deploy_local_to_remote_ssh_keys.sh && \
bash deploy_local_to_remote_ssh_keys.sh

### Local_Ubuntu_Server connect to Remote_Ubuntu_Server through ssh keys
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2222 ${REMOTE_USER}@${REMOTE_HOST}
ssh -p 22 ${REMOTE_USER}@${REMOTE_HOST}

# 其他配置
## 配置 Gotify 通知 - 交互方式
curl -fsSL -o setup_gotify_notify.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/setup_gotify_notify.sh && \
bash setup_gotify_notify.sh