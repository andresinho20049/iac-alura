terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.regiao_aws
  shared_config_files      = ["/home/user/.aws/config"]
  shared_credentials_files = ["/home/user/.aws/credentials"]
}

resource "aws_launch_template" "instance_template" {
  image_id = "ami-04b70fa74e45c3917"
  instance_type = var.instance_t
  key_name      = "iac_alura"

  tags = {
    Name = "Aws templante ${var.enviroment_team}"
  }
  security_group_names = [ aws_security_group.security_group_global.name ]
}

resource "aws_autoscaling_group" "scaling_group" {
  name = var.group_name
  max_size = var.group_max
  min_size = var.group_min
  availability_zones = [ "${var.regiao_aws}a", "${var.regiao_aws}b" ]
  launch_template {
    id = aws_launch_template.instance_template.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.load_balancer_target.arn ]
}

resource "aws_autoscaling_policy" "scaling_policy" {
  name = "policy_scaling_terraform"
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_autoscaling_schedule" "scaling_scredule_start" {
  scheduled_action_name = "schudule_terraform"
  desired_capacity = 1
  start_time = timeadd(timestamp(), "10m")
  recurrence = "0 7 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name
  count = var.enviroment_team == "production" ? 0 : 1
}

resource "aws_autoscaling_schedule" "scaling_scredule_stop" {
  scheduled_action_name = "schudule_terraform"
  desired_capacity = 1
  start_time = timeadd(timestamp(), "30m")
  recurrence = "0 18 * * 1-5"
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name
  count = var.enviroment_team == "production" ? 0 : 1
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "load_balancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id ]
}

resource "aws_lb_target_group" "load_balancer_target" {
  name = "lbTarget"
  port = "80"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default_vpc.id
}

resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target.arn
  }  
}

resource "aws_default_vpc" "default_vpc" {
  
}