data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_ecs_service" "app" {
  name            = "beer-app-service"
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_http_5000.id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.app]
}

