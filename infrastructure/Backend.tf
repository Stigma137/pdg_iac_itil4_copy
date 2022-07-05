resource "aws_launch_template" "lt_backend" {
  image_id               = var.ami_id
  name                   = var.back_launch_template_name
  instance_type          = var.back_launch_template_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.private_security_group_id]

  user_data = base64encode(templatefile("../infrastructure/back.sh", {RDS_HOSTNAME= "${aws_db_instance.default.address}"}))

  tags = {
    "responsible" = var.tag_responsible
  }

  tag_specifications {
    resource_type = var.resource_type_volume
    
    tags = {
        "responsible" = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = var.resource_type_instance
    
    tags = {
        "responsible" = var.tag_responsible,
        "Name"        = var.back_launch_template_instance_name
    }
  }
  depends_on = [
    aws_db_instance.default
  ]
}

resource "aws_autoscaling_group" "backend" {
  max_size            = var.max_size_ag
  min_size            = var.min_size_ag
  desired_capacity    = var.desired_capacity_ag
  vpc_zone_identifier = [var.private_subnet_id]
  target_group_arns   = [ aws_lb_target_group.backend_target_group.arn ]

  launch_template {
    id      = aws_launch_template.lt_backend.id
    version = "$Latest"
  }

  tag {
    key                 = "responsible"
    value               = var.tag_responsible
    propagate_at_launch = true
  }
}

resource "aws_lb" "backend_load_balancer" {
  name               = var.backend_lb_name
  load_balancer_type = var.backend_lb_type
  internal = true
  subnets            = [var.private_subnet_id, var.private1_subnet_id]
  security_groups    = [var.private_security_group_id]

  tags = {
      "responsible" = var.tag_responsible
  }

}

resource "aws_lb_listener" "http_back" {
  load_balancer_arn = aws_lb.backend_load_balancer.arn
  protocol          = var.backend_lbl_protocol
  port              = var.backend_lbl_port

  default_action {
    type             = var.lb_listener_type
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }
}

resource "aws_lb_target_group" "backend_target_group" {
  target_type = var.backend_tg_target_type
  protocol    = var.backend_tg_protocol
  port        = var.backend_tg_port
  vpc_id      = var.main_vpc_id

  health_check {
    path                = var.path_tg   
    protocol            = var.backend_tg_protocol 
    matcher             = var.matcher_tg 
    interval            = var.interval_tg    
    timeout             = var.timeout_tg
    healthy_threshold   = var.healthy_threshold_tg
    unhealthy_threshold = var.unhealthy_threshold_tg
}

} 