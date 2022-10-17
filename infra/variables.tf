variable "prefix" {
  type = string
}

variable "application_services" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "app_port" {
  type = number
}

variable "app_name" {
  type = string
  description = "Name of application"
}

variable "image_url" {
  type = string
  description = "URL for the docker image"
}
variable "api_memory" {
  type = number
  description = "Memory allocated for application for task"
}

variable "api_cpu" {
  type = number
  description = "CPU allocated for application for task"
}

variable "app_version" {
  type = string
  description = "Application version"
}

variable "listener_port" {
  type = string
}