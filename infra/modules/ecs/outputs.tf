############################################
# ECS Cluster
############################################

output "cluster_id" {
  description = "ECS Cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  description = "ECS Cluster ARN"
  value       = aws_ecs_cluster.this.arn
}

output "cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.this.name
}

############################################
# ECS Service
############################################

output "service_id" {
  description = "ECS Service ID"
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "ECS Service ARN"
  value       = aws_ecs_service.this.id
}

############################################
# Task Definition
############################################

output "task_definition_arn" {
  description = "Task Definition ARN"
  value       = aws_ecs_task_definition.this.arn
}

output "task_definition_family" {
  description = "Task Definition Family"
  value       = aws_ecs_task_definition.this.family
}

############################################
# Load Balancer
############################################

output "alb_id" {
  description = "Application Load Balancer ID"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Hosted Zone ID"
  value       = aws_lb.this.zone_id
}

############################################
# Target Group
############################################

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "Target Group Name"
  value       = aws_lb_target_group.this.name
}

############################################
# Security Groups
############################################

output "alb_security_group_id" {
  description = "ALB Security Group"
  value       = aws_security_group.alb.id
}

output "ecs_security_group_id" {
  description = "ECS Security Group"
  value       = aws_security_group.ecs.id
}

############################################
# IAM Roles
############################################

output "execution_role_arn" {
  description = "ECS Execution Role ARN"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "task_role_arn" {
  description = "ECS Task Role ARN"
  value       = aws_iam_role.ecs_task_role.arn
}

############################################
# CloudWatch
############################################

output "log_group_name" {
  description = "CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.ecs.name
}

############################################
# Auto Scaling
############################################

output "autoscaling_target_id" {
  description = "Auto Scaling Target"

  value = var.enable_autoscaling ? aws_appautoscaling_target.ecs[0].id : null
}

output "autoscaling_policy_arn" {
  description = "Auto Scaling Policy ARN"

  value = var.enable_autoscaling ? aws_appautoscaling_policy.cpu[0].arn : null
}