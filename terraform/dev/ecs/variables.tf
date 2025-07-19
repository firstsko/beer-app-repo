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
