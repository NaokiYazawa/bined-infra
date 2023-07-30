output "security_group_alb_id" {
  value = aws_security_group.alb.id
  description = "The ID of the security group created for the ALB."
}

output "security_group_ecs_id" {
  value = aws_security_group.ecs.id
  description = "The ID of the security group created for the ECS."
}

output "security_group_rds_id" {
  value = aws_security_group.rds.id
  description = "The ID of the security group created for the RDS."
}

output "security_group_bastion_id" {
  value = aws_security_group.bastion.id
  description = "The ID of the security group created for the Bastion server."
}
