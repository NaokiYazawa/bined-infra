# module "security_groups" {
#   source = "./modules/security_groups"

#   vpc_id                          = module.network.vpc_id
#   app_port                        = 8080
#   database_port                   = 5432
#   aws_security_group_alb_name     = "alb-sg"
#   aws_security_group_ecs_name     = "ecs-sg"
#   aws_security_group_rds_name     = "rds-sg"
#   aws_security_group_bastion_name = "bastion-sg"
# }
