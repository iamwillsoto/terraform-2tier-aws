variable "name_prefix" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "web_sg_id" {
  type = string
}

variable "db_endpoint" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
