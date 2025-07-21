resource "aws_db_instance" "postgres" {
  identifier              = "shippio-postgres-db"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.master_username
  password                = random_password.master.result
  port                    = 5432
  publicly_accessible     = true 
  skip_final_snapshot     = true
  #db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [var.security_group_name]
}
