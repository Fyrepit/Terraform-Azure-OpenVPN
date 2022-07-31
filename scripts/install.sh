#! /bin/bash

# Get openvpn-install.sh from github
sudo apt-get install wget
curl -O ${openvpn_install_script_path}

# Script inputs
export AUTO_INSTALL=${auto_install}
export APPROVE_IP=${approve_ip}
export IPV6_SUPPORT=${ipv6_support}
export PORT_CHOICE=${port_choice}
export PROTOCOL_CHOICE=${protocol_choice}
export DNS=${dns}
export COMPRESSION_ENABLED=${compression_enabled}
export CUSTOMIZE_ENC=${customize_enc}
export CLIENT=${export_client}
export PASS=${pass}
export ENDPOINT=$(curl -4 ifconfig.co)

# Install OpenVPN server
chmod +x openvpn-install.sh && bash openvpn-install.sh|tee /tmp/openvpn-install_`date +"%Y-%m-%d-%H-%M-%S"`.log

# Keep openvpn-install.sh under /home/ubuntu for future use
sudo wget ${openvpn_install_script_path} -P /home/ubuntu/
