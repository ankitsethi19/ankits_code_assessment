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
      #image        = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${lower(var.app_name)}:${var.app_version}"
      image        = "docker.io/ankits19/travel_perk_app:latest"
      #image        = "${data.aws_ecr_repository.app.repository_url}/${lower(var.app_name)}:${var.app_version}"
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
