resource "aws_ecs_service" "api" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.api_task_definition.arn
  desired_count   = 2
  launch_type = "FARGATE"

  network_configuration {
    subnets = data.aws_subnets.default_subnets.ids
    assign_public_ip = true
    security_groups = [aws_security_group.app_sg.id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name = var.app_name
    container_port = var.app_port
  }
}
