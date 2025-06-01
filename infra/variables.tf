resource "random_string" "name" {
  length  = 16
  upper   = false
  special = false
}

variable "name_prefix" {
  description = "Prefix for the random name"
  type        = string
  default     = "ppgd"
}

variable "environment" {
  default = "prod"
}

variable "python_port" {
  default = 8000
}
