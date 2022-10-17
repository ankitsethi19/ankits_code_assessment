resource "aws_ecs_task_definition" "api_task_definition" {
  family                   = var.app_name
  execution_role_arn       = data.aws_iam_role.ecs_role.arn
  memory                   = var.api_memory
  cpu                      = var.api_cpu
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name         = var.app_name
      image        = var.image_url
      cpu          = 10
      memory       = 128
      essential    = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort : var.app_port
        }
      ]
    }
  ])
}
