module "config_as_code" {
	source = "../infrastructure/"

	# RDS
	instance_class = local.instance_class
	allocated_storage = local.allocated_storage

	# Backend
	back_launch_template_instance_type = local.back_launch_template_instance_type
	max_size_ag = local.max_size_ag
	min_size_ag = local.min_size_ag
	desired_capacity_ag = local.desired_capacity_ag

	#Frontend
	front_launch_template_instance_type = local.front_launch_template_instance_type
}

locals {
	instance_class = var.environment == "prod" ? "db.t3.micro" : "db.t2.micro"

	allocated_storage = var.environment == "prod" ? 20 : 10
	
	back_launch_template_instance_type = var.environment == "prod" ? "t3.micro" : "t2.micro"

	front_launch_template_instance_type = var.environment == "prod" ? "t3.micro" : "t2.micro"

	max_size_ag = var.environment == "prod" ? 2 : 1

	min_size_ag = var.environment == "prod" ? 1 : 0
	
	desired_capacity_ag = var.environment == "prod" ? 2 : 1
}