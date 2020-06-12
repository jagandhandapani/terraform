variable "rgroup" {
  type = "string"
  default = "Test_RG"
}

variable "location" {
  type = "string"
  default = "EastUS"
}

variable "prefix" {
  type = "string"
  default = "test"
}
variable "vnet_address_space" {
  type = "string"
  default = "10.0.0.0/16" 
}

variable "web_server_subnet_name" {
  type = "string"
  default = "web_server_subnet"
}

variable "web_server_subnet_address_space" {
  type = "string"
  default = "10.0.1.0/24"
}

variable "app_server_subnet_address_space" {
  type = "string"
  default = "10.0.2.0/24"
}
