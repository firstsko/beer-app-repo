output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "admin_secret_arn" {
  value = module.rds.admin_secret_arn
}

output "app_user_secret_arn" {
  value = module.rds.app_user_secret_arn
}

output "rds_master_username" {
  value = module.rds.rds_master_username
}

output "rds_master_password" {
  value     = module.rds.rds_master_password
  sensitive = true
}

output "rds_app_password" {
  value     = module.rds.rds_app_password
  sensitive = true
}

output "rds_psql_connect_command" {
  value     = module.rds.rds_psql_connect_command
  sensitive = true
}
