##################################################################################
# DATA
##################################################################################
# AWS ELB Service Account
data "aws_elb_service_account" "root" {}

##################################################################################
# RESOURCES
##################################################################################
# AWS LoadBalancer
resource "aws_lb" "Nginx-LB" {
  name               = "kaushikb-lb-tf"
  internal           = false # Public ie External facing LB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_app_s3.web_bucket.id
    prefix  = "alb-logs"
    enabled = true
  }
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-Nginx-LB"
  })
}

# AWS LoadBalancer Target Group
resource "aws_lb_target_group" "nginx" {
  name     = "nginx-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-lb-target-group"
  })
}
# AWS LoadBalancer Listener
resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.Nginx-LB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb-listener"
  })
}
# AWS LoadBalancer Attachment 
resource "aws_lb_target_group_attachment" "nginx_lb_tg_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx[count.index].id
  port             = 80
}
