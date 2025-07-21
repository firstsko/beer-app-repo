resource "aws_ecs_cluster" "app_cluster" {
  name = var.cluster_name
}

