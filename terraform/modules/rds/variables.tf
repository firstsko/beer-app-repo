variable "db_name" {
  description = "The name of the initial database to create"
  type        = string
}

variable "master_username" {
  description = "Master username for RDS"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the RDS instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default     = false
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = ""
}

variable "security_group_name" {
  description = "Name of env security group"
  type        = string
  default     = "shippio-sg"
}


variable "rds_master_credentials" {
  description = "Name of rds master credential"
  type        = string
  default     = "shippio-rds-master-credential"
}

variable "rds_app_user_credentials" {
  description = "Name of app user credential"
  type        = string
  default     = "shippio-rds-app-user-credential"
}