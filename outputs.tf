output "public_ip" {
  value = "Public IP Address: ${azurerm_public_ip.pubip.ip_address}"
}

output "public_dns" {
  value = "Public DNS: ${azurerm_public_ip.pubip.fqdn}"
}
