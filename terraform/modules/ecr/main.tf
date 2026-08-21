data "aws_ecr_repository" "ticket_api" {
  name       = aws_ecr_repository.ticket_api.name
  depends_on = [aws_ecr_repository.ticket_api]
}

resource "aws_ecr_repository" "ticket_api" {
  name                 = "ticket_api"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
