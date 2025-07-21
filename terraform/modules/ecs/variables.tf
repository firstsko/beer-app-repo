variable "cluster_name" {
  description = "Name of the existing ECS cluster"
  type        = string
  default     = "shippio-ecs-cluster"
}

variable "ecr_repo" {
  description = "ECR repository URL"
  type        = string
  default     = "589140421825.dkr.ecr.ap-northeast-3.amazonaws.com/beer-app-repo"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "execution_role_arn" {
  description = "IAM execution role ARN"
  type        = string
  default     = "arn:aws:iam::589140421825:role/ecsTaskExecutionRole"
}


variable "app_port" {
  description = "Port that the app container listens on"
  type        = number
  default     = 5000
}


variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution IAM role"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_autoscaling_role_name" {
  description = "Name of the ECS autoscaling IAM role"
  type        = string
  default     = "ecsAutoscalingRole"
}

variable "security_group_name" {
  description = "Name of env security group"
  type        = string
  default     = "shippio-sg"
}

variable "flask_env" {
  description = "Flask environment (development or production)"
  type        = string
}