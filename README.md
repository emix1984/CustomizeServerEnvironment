
# Ubuntu desktop 24 user-ubuntu
curl -fsSL https://raw.githubusercontent.com/emix1984/CustomizeServerEnvironment/refs/heads/main/Setup_UbuntuDesktop_SshSrv.sh | sudo bash

# Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o Setup_DebianXfceVNC_PythonDev.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/Setup_DebianXfceVNC_PythonDev.sh && \
bash Setup_DebianXfceVNC_PythonDev.sh
