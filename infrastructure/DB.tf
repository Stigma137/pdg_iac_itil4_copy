resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.private.id
  publicly_accessible  = var.publicly_access
  vpc_security_group_ids = [var.private_security_group_id]
  }

resource "aws_db_subnet_group" "private" {
  name       = var.aws_db_subnet_group_name
  subnet_ids = [var.private_subnet_id, var.private1_subnet_id]

  tags = {
    Name = "DB in Private Subnet"
  }
}
