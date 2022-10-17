## ALB Security Group
resource "aws_security_group" "elb_sg" {
  name   = "${var.prefix}-api-elb-sg"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "internet_to_elb" {
  protocol          = "tcp"
  security_group_id = aws_security_group.elb_sg.id
  from_port         = var.listener_port
  to_port           = var.listener_port
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_to_ecs_task" {
  protocol          = "tcp"
  security_group_id = aws_security_group.elb_sg.id
  from_port         = var.app_port
  to_port           = var.app_port
  type              = "egress"
  cidr_blocks       = [for s in data.aws_subnet.default : s.cidr_block]
}

resource "aws_security_group" "app_sg" {
  name = "${var.prefix}-app-sg"
  vpc_id = data.aws_vpc.default.id
  description = "Security group created for API"
}

resource "aws_security_group_rule" "traffic_to_api" {
  security_group_id = aws_security_group.app_sg.id
  protocol          = "tcp"
  from_port         = var.app_port
  to_port           = var.app_port
  type              = "ingress"
  cidr_blocks       = [for s in data.aws_subnet.default : s.cidr_block]
}

resource "aws_security_group_rule" "api_to_internet" {
  security_group_id = aws_security_group.app_sg.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
