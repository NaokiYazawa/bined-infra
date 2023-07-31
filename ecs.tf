module "ecs" {
  source = "./modules/ecs/"

  ecs_cluster_name             = local.common_name
  ecs_service_name             = local.common_name
  ecs_service_desired_count    = 1
  private_subnets              = module.network.private_subnets
  security_group_ecs_id        = module.security_groups.security_group_ecs_id
  alb_target_group_arn         = module.alb.target_group_arn
  container_name               = local.common_name
  container_port               = 8080
  family                       = local.common_name
  cloudwatch_log_group_name    = local.common_name
  ecs_task_execution_role_name = "ecs-task-execution-role-name-dev"
}
