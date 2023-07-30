output "target_group_arn" {
  value       = aws_lb_target_group.main.arn
  description = "The ARN of the target group associated with the ALB."
}
