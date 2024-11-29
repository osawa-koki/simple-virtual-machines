variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key."
}

variable "network_interface_id" {
  type        = string
  description = "ID of the network interface."
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group object containing name and location"
}
