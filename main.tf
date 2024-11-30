resource "azurerm_resource_group" "my_rg" {
  name     = "${var.project_name}-rg"
  location = "japaneast"
}

module "network" {
  source = "./modules/network"

  project_name = var.project_name
  resource_group = {
    name     = azurerm_resource_group.my_rg.name
    location = azurerm_resource_group.my_rg.location
  }
}

module "compute" {
  source = "./modules/compute"

  project_name   = var.project_name
  ssh_public_key = var.ssh_public_key
  resource_group = {
    name     = azurerm_resource_group.my_rg.name
    location = azurerm_resource_group.my_rg.location
  }
  network_interface_id = module.network.network_interface_id
}
