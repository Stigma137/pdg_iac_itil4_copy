data "template_file" "init" {
  template = "${file("../infrastructure/front.sh")}"

  vars = {
    BACKIP= "${aws_lb.backend_load_balancer.dns_name}"
  }
}

resource "aws_launch_template" "lt_frontend" {
  image_id               = var.ami_id
  name                   = var.front_launch_template_name
  instance_type          = var.front_launch_template_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.public_security_group_id]

  user_data = "${base64encode(data.template_file.init.rendered)}"

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
        "Name"        = var.front_launch_template_instance_name
    }
  }
  depends_on = [
    aws_launch_template.lt_backend
  ]
}

resource "aws_autoscaling_group" "frontend" {
  max_size            = var.max_size_ag
  min_size            = var.min_size_ag
  desired_capacity    = var.desired_capacity_ag
  vpc_zone_identifier = [var.public_subnet_id]
  target_group_arns   = [ aws_lb_target_group.frontend_target_group.arn ]

  launch_template {
    id      = aws_launch_template.lt_frontend.id
    version = "$Latest"
  }

   tag {
    key                 = "responsible"
    value               = var.tag_responsible
    propagate_at_launch = true
  }

  depends_on = [
    aws_autoscaling_group.backend
  ]
}

resource "aws_lb_target_group" "frontend_target_group" {
  target_type = var.frontend_tg_target_type
  protocol    = var.frontend_tg_protocol
  port        = var.frontend_tg_port
  vpc_id      = var.main_vpc_id

  health_check {
    path                = var.path_tg   
    protocol            = var.frontend_tg_protocol 
    matcher             = var.matcher_tg 
    interval            = var.interval_tg    
    timeout             = var.timeout_tg
    healthy_threshold   = var.healthy_threshold_tg
    unhealthy_threshold = var.unhealthy_threshold_tg
}

}

resource "aws_lb" "frontend_load_balancer" {
  name               = var.frontend_lb_name
  load_balancer_type = var.frontend_lb_type
  subnets            = [var.public_subnet_id, var.public1_subnet_id]
  security_groups    = [var.public_security_group_id]

  tags = {
      "responsible" = var.tag_responsible
  }
}

resource "aws_lb_listener" "http_front" {
  load_balancer_arn = aws_lb.frontend_load_balancer.arn
  protocol          = var.frontend_lbl_protocol
  port              = var.frontend_lbl_port

  default_action {
    type             = var.lb_listener_type
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
}