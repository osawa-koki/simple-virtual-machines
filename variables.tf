variable "client_id" {
  type        = string
  description = "Azure client id."
}

variable "client_secret" {
  type        = string
  description = "Azure client secret."
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant id."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription id."
}

variable "project_name" {
  type        = string
  default     = "simple-vm-instance"
  description = "Name of the project."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key."
}
