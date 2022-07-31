# variables.tf

variable "subscription_id" {
  type = string
  description = "Subscription Id of Azure account"
}

variable "client_id" {
  type = string
  description = "Client Id of Azure account"
}

variable "client_secret" {
  type = string
  description = "Client secret of Azure account"
}

variable "tenant_id" {
  type = string
  description = "Tenant Id of Azure account"
}


variable "prefix" {
  type        = string
  default     = "ovpn"
  description = "Prefix to generate names"
}

variable "location" {
  type        = string
  default     = "westeurope1"
  description = "Azure region"
}

variable "hostname" {
  type        = string
  default     = "openvpn"
  description = "Hostname of OpenVPN instance"
}

variable "admin_username" {
  type        = string
  default     = "ubuntu"
  description = "OS username of ubuntu instance"
}

variable "vnet_cidr" {
  type    = string
  default = "172.16.0.0/16"
  description = "CIDR block for VNET"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
  description = "VM shape"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/ssh.pub"
  description = "SSH public key path"
}

variable "storage_account_type" {
  type    = string
  default = "Standard_LRS"
  description = "Storage type"
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
  description = "OS disk caching"
}

variable "os_image" {
  type = map(string)
  description = "OS image details"

  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

# OpenVPN Install variables

variable "openvpn_install_script_path" {
  type = string
  default = "https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh"
  description = "OPENVPN script download path"
}
variable "auto_install" {
  type = string
  default = "y"
  description = "Autoinstall openVPN"
}

variable "approve_ip" {
  type = string
  default = "y"
  description = "Approve discovered IP"
}

variable "ipv6_support" {
  type = string
  default = "n"
  description = "IPV6 support"
}

variable "port_choice" {
  type = string
  default = "1"
  description = "Default port choice"
}

variable "protocol_choice" {
  type = string
  default = "1"
  description = "Default protocol choice"
}

variable "dns" {
  type = string
  default = "1"
  description = "Default DNS choice"
}

variable "compression_enabled" {
  type = string
  default = "n"
  description = "Default compression choice"
}

variable "customize_enc" {
  type = string
  default = "n"
  description = "No encryption customization"
}

variable "export_client" {
  type = string
  default = "client"
  description = "Client certificate name"
}

variable "pass" {
  type = string
  default = "1"
  description = "Proceed for install"
}




