variable "subscription_id" {
  type        = string
  description = "Azure subscription id."
}

variable "project_name" {
  type        = string
  default     = "simple-vm-instance"
  description = "Name of the project."
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the public key."
}
