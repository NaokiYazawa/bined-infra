variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created."
  type        = string
}

variable "app_port" {
  description = "The application port that the security group will allow."
  type        = number
}

variable "database_port" {
  description = "The database port that the security group will allow."
  type        = number
}

variable "aws_security_group_alb_name" {
  description = "Name of Security Group For Alb"
  type        = string
}

variable "aws_security_group_ecs_name" {
  description = "Name of Security Group For ECS"
  type        = string
}

variable "aws_security_group_rds_name" {
  description = "Name of Security Group For RDS"
  type        = string
}

variable "aws_security_group_bastion_name" {
  description = "Name of Security Group For Bastion"
  type        = string
}
