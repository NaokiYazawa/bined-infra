data "aws_secretsmanager_secret" "db_password" {
  name = "bined/db-password"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

resource "aws_db_instance" "main" {
  identifier              = local.common_name
  db_name                 = "hasuradefault"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "15.2"
  instance_class          = "db.t3.small"
  db_subnet_group_name    = module.network.database_subnet_group_name
  password                = data.aws_secretsmanager_secret_version.db_password.secret_string
  username                = "hasurauser"
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  deletion_protection     = false
  vpc_security_group_ids  = [module.security_groups.security_group_rds_id]
}
