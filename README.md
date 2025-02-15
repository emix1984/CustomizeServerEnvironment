
# NoVNC-DebianXfce
used for preset Ubuntu Server
OS: Ubuntu Server 22.04 LTS (Jammy Jellyfish)

preset: openssh-server, CasaOS

# Debian & Ubuntu Server with user-root
apt update && apt install -y curl && \
curl -fsSL -o UbuntuServer_init.sh https://github.com/emix1984/CustomizeServerEnvironment/raw/refs/heads/main/UbuntuServer_init.sh && \
bash UbuntuServer_init.sh
