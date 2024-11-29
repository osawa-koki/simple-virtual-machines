variable "project_name" {
  type        = string
  description = "Name of the project."
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group object containing name and location"
}
