# terraform.tfvars

# Azure account secrets
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""

# Azure region
location = "uksouth"

# Hostname of Linux VM instance
hostname = "terraform-openvpn"

# VNET CIDR (/16)
vnet_cidr = "172.16.0.0/16"

# VM Shape
vm_size = "Standard_B1s"

# Public SSH Key path
ssh_public_key_path = "~/.ssh/ssh.pub"