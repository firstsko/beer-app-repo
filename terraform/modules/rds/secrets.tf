resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()_+=-{}[]:;<>,.?~" 
}

resource "random_password" "app_user" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()_+=-{}[]:;<>,.?~"
}


resource "aws_secretsmanager_secret" "rds_admin" {
  name = var.rds_master_credentials
}

resource "aws_secretsmanager_secret_version" "rds_admin_version" {
  secret_id     = aws_secretsmanager_secret.rds_admin.id
  secret_string = jsonencode({
    username = var.master_username
    password = random_password.master.result
  })
}

resource "aws_secretsmanager_secret" "rds_app_user" {
  name = var.rds_app_user_credentials
}

resource "aws_secretsmanager_secret_version" "rds_app_user_version" {
  secret_id     = aws_secretsmanager_secret.rds_app_user.id
  secret_string = jsonencode({
    username = "app_user"
    password = random_password.app_user.result
  })
}

