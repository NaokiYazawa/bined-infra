# module "alb" {
#   source                = "./modules/alb/"
#   vpc_id                = module.network.vpc_id
#   public_subnet_ids     = module.network.public_subnets
#   security_group_alb_id = module.security_groups.security_group_alb_id
#   alb_name              = local.common_name
#   alb_target_group_name = "${local.common_name}-alb-target-group"
#   alb_log_name          = "${local.common_name}-alb-log-bucket"
# }
