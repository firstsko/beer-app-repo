output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "admin_secret_arn" {
  value = aws_secretsmanager_secret.rds_admin.arn
}

output "app_user_secret_arn" {
  value = aws_secretsmanager_secret.rds_app_user.arn
}

output "rds_master_username" {
  description = "RDS master username"
  value       = var.master_username
}

output "rds_master_password" {
  value     = random_password.master.result
  sensitive = true
}


output "rds_app_password" {
  value     = random_password.master.result
  sensitive = true
}

output "rds_psql_connect_command" {
  description = "One-liner psql command to connect"
  value       = "PGPASSWORD='${random_password.master.result}' psql -h ${aws_db_instance.postgres.address} -U ${var.master_username} -d ${var.db_name}"
  sensitive   = true 
}
