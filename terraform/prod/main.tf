provider "aws" {
  region = var.aws_region
}

module "security" {
  source              = "../modules/security"
  security_group_name = "shippio-dev-sg"
  ingress_ports       = [5000, 5432]
  allowed_cidrs       = ["0.0.0.0/0"]
}

module "ecs" {
  source            = "../modules/ecs"
  cluster_name      = var.cluster_name
  ecr_repo          = var.ecr_repo
  image_tag         = var.image_tag
  execution_role_arn = var.execution_role_arn
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_autoscaling_role_name    = var.ecs_autoscaling_role_name
  security_group_name = module.security.security_group_id
  flask_env           = var.flask_env
}


module "rds" {
  source          = "../modules/rds"
  db_name         = var.db_name
  master_username = var.master_username
  allowed_cidrs   = var.allowed_cidrs
  security_group_name = module.security.security_group_id
}


