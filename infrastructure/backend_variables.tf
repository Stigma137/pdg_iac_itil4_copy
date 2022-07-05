variable "back_launch_template_name" {
  type    = string
  default = "terraform-launch-template-backend"
}

variable "back_launch_template_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "back_launch_template_instance_name" {
  type = string
  default = "tf-instance-backend"
}

variable "backend_tg_target_type" {
  type    = string
  default = "instance"
}

variable "backend_tg_protocol" {
  type    = string 
  default = "HTTP"
}

variable "backend_tg_port" {
  type    = number
  default = 3000
}

variable "backend_lb_name" {
  type    = string 
  default = "backend"
}

variable "backend_lb_type" {
  type    = string
  default = "application"
}

variable "backend_lbl_protocol" {
  type    = string
  default = "HTTP"
}

variable "backend_lbl_port" {
  type    = number
  default = 3000
}

variable "private_security_group_id" {
  type    = string
  default = "sg-056809186f4c1b8ef"
}

variable "private_subnet_id" {
  type    = string
  default = "subnet-006411107512e33d7"
}

variable "private1_subnet_id" {
  type    = string
  default = "subnet-09f98f104df74b5f9"
}


