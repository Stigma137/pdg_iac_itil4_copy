variable "project_tags" {
  type        = map(string)
  default = {
    project = "pdg_iac_itil4"
  }
}

variable "region" {
	type = string 
	default = "us-east-1"
}

variable "vpc_cidr_block" {
	type = string 
	default = "10.0.0.0/16"
}

variable "public_ip" {
  type        = string
  description = "Your public IP goes here"
  default     = "10.0.1.0/24"
}

variable "public1_ip" {
  type        = string
  description = "Your public IP goes here"
  default     = "10.0.3.0/24"
}

variable "private_ip" {
  type        = string
  description = "Your private IP goes here"
  default     = "10.0.2.0/24"
}

variable "private1_ip" {
  type        = string
  description = "Your private IP goes here"
  default     = "10.0.5.0/24"
}

variable "tcp_protocol" {
  type        = string
  default     = "tcp"
}

variable "upd_protocol" {
  type        = string
  default     = "udp"
}


variable "cidr_block_nat" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "enable_dns_hostnames" {
	type = bool
	default = true
}

variable "enable_dns_support" {
	type = bool
	default = true
}

variable "enable_classiclink_dns_support" {
	type = bool
	default = true
}

variable "vpc" {  
	type = bool
	default = true
}

variable "http_port" {
	type = number
	default = 80
}

variable "https_port" {
	type = number
	default = 443
}

variable "ssh_port" {
	type = number
	default = 22
}

variable "db_port" {
	type = number
	default = 3306
}

variable "api_port" {
	type = number
	default = 3000
}

variable "ui_port" {
	type = number
	default = 3030
}

variable "last_unused_port" {
	type = number
	default = 65535
}

variable "linux_distro_port" {
	type = number
	default = 32768
}

variable "public_secure_group_name" {
  type        = string
  default     = "public_security_group"
}

variable "private_secure_group_name" {
  type        = string
  default     = "private_security_group"
}

variable "map_public_ip_on_launch" {
	type = bool
	default = true
}

variable "main_vpc_id" {
  type        = string
  default     = "vpc-0ed312fbac4fb2ba3"
}
