
# NoVNC-DebianXfce used for python-dev
apt update && apt install -y curl && \
curl -fsSL -o Setup_DebianXfceVNC_PythonDev.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/Setup_DebianXfceVNC_PythonDev.sh && \
bash Setup_DebianXfceVNC_PythonDev.sh

# Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o UbuntuServer_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh

# Ubuntu desktop 24 used for install ssh-srv
curl -fsSL https://raw.githubusercontent.com/emix1984/CustomizeServerEnvironment/refs/heads/main/Setup_UbuntuDesktop_SshSrv.sh | sudo bash
