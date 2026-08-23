
variable "ecr_repo_url" {
  type = string
  description = "ecs repository url"
}

variable "ecs_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "public_subnet" {
}

variable "security_group" {
}