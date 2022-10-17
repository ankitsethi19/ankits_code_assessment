resource "aws_ecs_cluster" "cluster" {
  name = "${var.prefix}-ecs-cluster"
  tags = {
    Name = "${var.prefix}-ecs-cluster"
    CreatedBy = "Terraform"
  }
}
