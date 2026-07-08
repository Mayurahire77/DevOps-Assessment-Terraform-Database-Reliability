############################################
# Network Outputs
############################################

output "vpc_id" {

  description = "Production VPC ID"

  value = module.network.vpc_id

}


output "public_subnet_ids" {

  description = "Production Public Subnet IDs"

  value = module.network.public_subnet_ids

}


output "private_app_subnet_ids" {

  description = "Production Private Application Subnets"

  value = module.network.private_app_subnet_ids

}


output "private_db_subnet_ids" {

  description = "Production Private Database Subnets"

  value = module.network.private_db_subnet_ids

}



############################################
# ECS Outputs
############################################

output "ecs_cluster_name" {

  description = "ECS Cluster Name"

  value = module.ecs.cluster_name

}


output "ecs_cluster_arn" {

  description = "ECS Cluster ARN"

  value = module.ecs.cluster_arn

}


output "ecs_service_name" {

  description = "ECS Service Name"

  value = module.ecs.service_name

}


output "alb_dns_name" {

  description = "Application Load Balancer DNS"

  value = module.ecs.alb_dns_name

}


output "alb_arn" {

  description = "Application Load Balancer ARN"

  value = module.ecs.alb_arn

}



############################################
# RDS Outputs
############################################

output "database_endpoint" {

  description = "Production Database Endpoint"

  value = module.rds.db_endpoint

}


output "database_address" {

  description = "Production Database Address"

  value = module.rds.db_address

}


output "database_port" {

  description = "Database Port"

  value = module.rds.db_port

}


output "database_name" {

  description = "Database Name"

  value = module.rds.db_name

}


output "database_security_group_id" {

  description = "RDS Security Group ID"

  value = module.rds.security_group_id

}



############################################
# Deployment Information
############################################

output "environment" {

  description = "Environment Name"

  value = var.environment

}