
# NoVNC-DebianXfce
dockerhub: consol/debian-xfce-vnc:v2.0.3

## NoVNC-DebianXfce used for python-dev with chromium_dirver
apt update && apt install -y curl && \
curl -fL -o Setup_DebianXfceVNC_PythonDev.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/Setup_DebianXfceVNC_PythonDev.sh && \
chmod +x Setup_DebianXfceVNC_PythonDev.sh && \
bash Setup_DebianXfceVNC_PythonDev.sh y

## NoVNC-DebianXfce used for python-dev without chromium_dirver
apt update && apt install -y curl && \
curl -fL -o Setup_DebianXfceVNC_PythonDev.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/Setup_DebianXfceVNC_PythonDev.sh && \
chmod +x Setup_DebianXfceVNC_PythonDev.sh && \
bash Setup_DebianXfceVNC_PythonDev.sh

# Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o UbuntuServer_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh
