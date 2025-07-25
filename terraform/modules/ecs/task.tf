resource "aws_ecs_task_definition" "app" {
  family                   = "beer-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "beer-app"
      image     = "${var.ecr_repo}:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          protocol      = "tcp"
        }
      ],
      environment = [
      {
        name  = "FLASK_ENV"
        value = var.flask_env
      }
    ]
    }
  ])
}

