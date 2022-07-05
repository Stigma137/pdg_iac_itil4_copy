variable "ami_id" {
	type = string 
	default = "ami-052efd3df9dad4825"
}

variable "front_launch_template_name" {
  type    = string
  default = "terraform-launch-template-frontend"
}

variable "front_launch_template_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "admin"
}

variable "tag_responsible" {
  type    = string
  default = "admin"
}

variable "resource_type_volume" {
  type    = string
  default = "volume"
}

variable "resource_type_instance" {
  type    = string
  default = "instance"
}

variable "front_launch_template_instance_name" {
  type = string
  default = "tf-instance-frontend"
}

variable "max_size_ag" {
  type    = number
  default = 1
}

variable "min_size_ag" {
  type    = number
  default = 0
}

variable "desired_capacity_ag" {
  type    = number
  default = 1
}

variable "frontend_tg_target_type" {
  type    = string
  default = "instance"
}

variable "frontend_tg_protocol" {
  type    = string 
  default = "HTTP"
}

variable "frontend_tg_port" {
  type    = number
  default = 3030
}

variable "path_tg" {
  type    = string 
  default = "/"
}

variable "matcher_tg" {
  type    = string
  default = "200"
}

variable "interval_tg" {
  type    = number
  default = 30
}

variable "timeout_tg" {
  type    = number
  default = 5
}

variable "healthy_threshold_tg" {
  type    = number
  default = 5
}

variable "unhealthy_threshold_tg" {
  type    = number
  default = 2
}

variable "frontend_lb_name" {
  type    = string 
  default = "frontend"
}

variable "frontend_lb_type" {
  type    = string
  default = "application"
}

variable "frontend_lbl_protocol" {
  type    = string
  default = "HTTP"
}

variable "frontend_lbl_port" {
  type    = number
  default = 3030
}

variable "lb_listener_type" {
  type    = string
  default = "forward"
}

variable "public_security_group_id" {
  type    = string
  default = "YOUR_PUBLIC_SECURITY_GROUP_ID"
}

variable "public_subnet_id" {
  type    = string
  default = "YOUR_PUBLIC_SUBNET_ID"
}

variable "public1_subnet_id" {
  type    = string
  default = "YOUR_PUBLIC1_SUBNET_ID"
}



