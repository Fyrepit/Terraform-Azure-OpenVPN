
data "template_file" "deployment_shell_script" {
  template = file("${path.module}/scripts/install.sh")
  vars = {
    openvpn_install_script_path = var.openvpn_install_script_path
    auto_install                = var.auto_install
    approve_ip                  = var.approve_ip
    ipv6_support                = var.ipv6_support
    port_choice                 = var.port_choice
    protocol_choice             = var.protocol_choice
    dns                         = var.dns
    compression_enabled         = var.compression_enabled
    customize_enc               = var.customize_enc
    export_client               = var.export_client
    pass                        = var.pass
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = var.hostname
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  custom_data         = base64encode(data.template_file.deployment_shell_script.rendered)

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.os_image["publisher"]
    offer     = var.os_image["offer"]
    sku       = var.os_image["sku"]
    version   = var.os_image["version"]
  }

  tags = {
    environment = "OpenVPN"
  }
}