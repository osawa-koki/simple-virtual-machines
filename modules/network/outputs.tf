output "public_ip_address" {
  value       = azurerm_public_ip.my_public_ip.ip_address
  description = "Public IP address of the virtual machine."
}

output "network_interface_id" {
  value       = azurerm_network_interface.my_nic.id
  description = "ID of the network interface."
}
