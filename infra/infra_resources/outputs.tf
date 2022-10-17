output "application_url" {
  value = "http://${aws_alb.alb_api.dns_name}:${var.listener_port}"
}