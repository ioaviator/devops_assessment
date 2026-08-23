
# ecs cluster
resource "aws_ecs_cluster" "main" {
  name       = "ticket_api_cluster"
}

# ecs task definition
resource "aws_ecs_task_definition" "ticket_api" {
  family                   = "ticket_api_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  execution_role_arn = var.ecs_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "ticket_api"
      image     = var.ecr_repo_url
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/ticket_api"
          "awslogs-region"        = "eu-north-1"
          "awslogs-stream-prefix" = "ecs"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])
}

# ecs service
resource "aws_ecs_service" "ticket_api_service" {
  name            = "ticket_api_service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ticket_api.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [var.public_subnet]
    security_groups  = [var.security_group]
    assign_public_ip = true
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

}