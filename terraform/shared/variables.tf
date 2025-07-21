variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}
