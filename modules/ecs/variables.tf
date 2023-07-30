variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "ecs_service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "ecs_service_desired_count" {
  description = "The number of tasks to run on the ECS service."
  type        = number
}

variable "private_subnets" {
  description = "List of private subnet IDs for the ECS service."
  type        = list(string)
}

variable "security_group_ecs_id" {
  description = "The ID of the security group associated with the ECS service."
  type        = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the target group for the ECS service."
  type        = string
}

variable "container_name" {
  description = "The name of the container."
  type        = string
}

variable "container_port" {
  description = "The port on which the container is listening."
  type        = number
}

variable "family" {
  description = "The family of the Task Definition."
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group."
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of ECS Task Execution"
  type        = string
}
