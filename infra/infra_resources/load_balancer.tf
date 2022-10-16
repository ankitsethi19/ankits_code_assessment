resource "aws_alb" "alb_api" {
  name               = "${var.prefix}-api"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_subnets.ids
  security_groups    = [aws_security_group.elb_sg.id]
}

#Dynamically create the alb target groups for app services
resource "aws_alb_target_group" "alb_target_group" {
  name = "${var.prefix}-api-tg"
  port = var.app_port
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
  }

}

#Create the alb listener for the load balancer
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb_api.id
  port = var.listener_port
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}