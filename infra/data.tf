data "aws_caller_identity" "current" {}

data "aws_vpc" "default"{
 default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default_subnets.ids)
  id       = each.value
}

data "aws_iam_role" "ecs_role" {
  name = "ecsTaskExecutionRole"
}
