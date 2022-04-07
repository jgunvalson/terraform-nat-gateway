variable "name" {
  type = string
}

variable "eip_private_ip" {
  type    = string
  default = null
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}