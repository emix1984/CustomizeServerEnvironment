used for preset Ubuntu Server
OS: Ubuntu Server 22.04 LTS (Jammy Jellyfish)

preset: openssh-server, CasaOS

# Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o UbuntuServer_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh


# Deploy Local_Ubuntu_Server ssh keys to Remote_Ubuntu_Server
apt update && apt install -y curl && \
curl -fsSL -o deploy_local_to_remote_ssh_keys.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/deploy_local_to_remote_ssh_keys.sh && \
bash deploy_local_to_remote_ssh_keys.sh

## Local_Ubuntu_Server connect to Remote_Ubuntu_Server through ssh keys
ssh-copy-id -i ~/.ssh/id_rsa.pub -p 2222 ${REMOTE_USER}@${REMOTE_HOST}
ssh -p 22 ${REMOTE_USER}@${REMOTE_HOST}
