# module "db" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = local.common_name

#   # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
#   engine               = "postgres"
#   engine_version       = "15"
#   family               = "postgres15" # DB parameter group
#   major_engine_version = "15"         # DB option group
#   instance_class       = "db.t3.small"

#   allocated_storage     = 20
#   max_allocated_storage = 100

#   # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
#   # "Error creating DB Instance: InvalidParameterValue: MasterUsername
#   # user cannot be used as it is a reserved word used by the engine"
#   db_name  = "hasuradefault"
#   username = "hasurauser"
#   port     = 5432

#   multi_az               = false
#   availability_zone      = "ap-northeast-1a"
#   db_subnet_group_name   = module.network.database_subnet_group_name
#   vpc_security_group_ids = [module.security_groups.security_group_rds_id]

#   backup_retention_period = 1
#   skip_final_snapshot     = true
#   deletion_protection     = false

#   parameters = [
#     {
#       name  = "autovacuum"
#       value = 1
#     },
#     {
#       name  = "client_encoding"
#       value = "utf8"
#     }
#   ]

#   db_option_group_tags = {
#     "Sensitive" = "low"
#   }
#   db_parameter_group_tags = {
#     "Sensitive" = "low"
#   }
# }


# resource "aws_db_instance" "main" {
#   identifier              = local.common_name
#   db_name                 = "hasuradefault"
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   engine                  = "postgres"
#   engine_version          = "15.2"
#   instance_class          = "db.t3.small"
#   db_subnet_group_name    = module.network.database_subnet_group_name
#   password                = "hasurapassword"
#   username                = "hasurauser"
#   backup_retention_period = 0
#   multi_az                = false
#   skip_final_snapshot     = true
#   deletion_protection     = false
#   vpc_security_group_ids  = [module.security_groups.security_group_rds_id]
# }
