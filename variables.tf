variable "project_name" {
  type        = string
  default     = "simple-vm-instance"
  description = "Name of the project."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key."
}
