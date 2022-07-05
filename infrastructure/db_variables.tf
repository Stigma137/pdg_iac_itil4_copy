variable "allocated_storage" {
	type = number
	default = 10
}
variable "engine" {
	type = string
	default = "mysql"
}
variable "engine_version" {
	type = string
	default = "5.7" 
}
variable "instance_class" {
	type = string
	default = "db.t2.micro"
}
variable "db_name" {
	type = string
	default = "mydb"
}
variable "username" {
	type = string
	default = "stig"
}
variable "password" {
	type = string
	default = "stigma1234"
}
variable "parameter_group_name" {
	type = string
	default = "default.mysql5.7"
}
variable "skip_final_snapshot" {
	type = bool
	default = true
}

variable "aws_db_subnet_group_name" {
	type = string
	default = "private"
}

variable "publicly_access" {
	type = bool	
	default = true
}

