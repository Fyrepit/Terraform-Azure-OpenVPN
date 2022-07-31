# network.tf

locals {
  // VCN is /16
  vcn_subnet_cidr_offset = 8
  vpn_subnet_prefix  = cidrsubnet(var.vnet_cidr, local.vcn_subnet_cidr_offset, 0)
}

# Create Azure Virtual Network (VNET)
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_cidr]
  location            = var.location
  dns_servers         = ["1.1.1.1", "9.9.9.9"]

  tags = {
    environment = "OpenVPN"
  }
}

# Create vpn subnet
resource "azurerm_subnet" "vpnsubnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.vpn_subnet_prefix]

}

# Create security group
resource "azurerm_network_security_group" "sg" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "PermitSSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    #source_address_prefix      = var.restrict_ssh == true ? (jsondecode(data.http.geoipdata.body)).geoplugin_request : "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "PermitOpenVPNAdminInbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "943"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "PermitOpen443Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                   = "PermitOpenVPNInbound"
    priority               = 130
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Udp"
    source_port_range      = "*"
    destination_port_range = "1194"
    source_address_prefix  = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "OpenVPN"
  }

}

# Generate random string
resource "random_string" "dns-name" {
  length = 4
  upper  = false
  lower  = true
  #number  = 2
  special = false
}

# Create public IP
resource "azurerm_public_ip" "pubip" {
  name                = "${var.hostname}-public"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "openvpn${random_string.dns-name.result}"

  tags = {
    environment = "OpenVPN"
  }
}

resource "azurerm_network_interface" "nic" {
  name                 = "${var.hostname}-nic"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = var.hostname
    subnet_id                     = azurerm_subnet.vpnsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip.id
  }

  tags = {
    environment = "OpenVPN"
  }

}

resource "azurerm_network_interface_security_group_association" "allow-vpn" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.sg.id
}