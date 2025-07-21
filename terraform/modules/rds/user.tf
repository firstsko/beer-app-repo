resource "null_resource" "init_db_user" {
  provisioner "local-exec" {
    command = <<EOT
    echo "MASTER PASSWORD: ${random_password.master.result}"
    echo "APP PASSWORD: ${random_password.app_user.result}"
    export PGPASSWORD='${random_password.master.result}'
    psql -h ${aws_db_instance.postgres.address} -U ${var.master_username} -d ${var.db_name} -c "CREATE USER app_user WITH PASSWORD '${random_password.app_user.result}';"
    psql -h ${aws_db_instance.postgres.address} -U ${var.master_username} -d ${var.db_name} -c "GRANT CONNECT ON DATABASE ${var.db_name} TO app_user;"
    psql -h ${aws_db_instance.postgres.address} -U ${var.master_username} -d ${var.db_name} -c "GRANT USAGE ON SCHEMA public TO app_user;"
    psql -h ${aws_db_instance.postgres.address} -U ${var.master_username} -d ${var.db_name} -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;"
    EOT
  }

  depends_on = [aws_db_instance.postgres]
}

