output "ecr_repo_url" {
  type = string
  value = data.aws_ecr_repository.ticket_api.repository_url
}