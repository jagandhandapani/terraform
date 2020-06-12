variable "rgroup" {
  type = "string"
}

variable "location" {
  type = "string"
}

variable "prefix" {
  type = "string"
}
variable "vnet_address_space" {
  type = "string"
}

variable "web_server_subnet_name" {
  type = "string"
}

variable "web_server_subnet_address_space" {
  type = "string"
  default = "10.0.1.0/24"
}

variable "app_server_subnet_address_space" {
  type = "string"
  default = "10.0.2.0/24"
}
