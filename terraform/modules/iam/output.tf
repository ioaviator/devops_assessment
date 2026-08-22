output "ecs_execution_role_arn" {
  type = string
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  type = string
  value = aws_iam_role.ecs_task_role.arn
}