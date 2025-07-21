variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

#RDS 
variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "master_username" {
  description = "Master username for RDS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS deployment"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the RDS"
  type        = list(string)
}

#ECS
variable "cluster_name" {
  type = string
}

variable "ecr_repo" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "ecs_task_execution_role_name" {
  type        = string
}

variable "ecs_autoscaling_role_name" {
  type        = string
}