variable "vpc_id" {
  description = "The ID of the VPC in which to create the target group."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of subnet IDs to attach to the load balancer."
  type        = list(string)
}

variable "security_group_alb_id" {
  description = "The ID of the ALB security group"
  type        = string
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "alb_target_group_name" {
  description = "Name of the ALB Target Group"
  type        = string
}

variable "alb_log_name" {
  description = "Name of the ALB Log"
  type        = string
}
