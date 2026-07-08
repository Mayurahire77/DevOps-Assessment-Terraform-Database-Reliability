############################################
# Network Outputs
############################################

output "vpc_id" {

  description = "VPC ID"

  value = module.network.vpc_id

}


output "public_subnet_ids" {

  description = "Public Subnet IDs"

  value = module.network.public_subnet_ids

}


output "private_app_subnet_ids" {

  description = "Private Application Subnet IDs"

  value = module.network.private_app_subnet_ids

}


output "private_db_subnet_ids" {

  description = "Private Database Subnet IDs"

  value = module.network.private_db_subnet_ids

}



############################################
# ECS Outputs
############################################

output "ecs_cluster_name" {

  description = "ECS Cluster Name"

  value = module.ecs.cluster_name

}


output "ecs_service_name" {

  description = "ECS Service Name"

  value = module.ecs.service_name

}


output "alb_dns_name" {

  description = "Application Load Balancer DNS"

  value = module.ecs.alb_dns_name

}



############################################
# RDS Outputs
############################################

output "database_endpoint" {

  description = "RDS Endpoint"

  value = module.rds.db_endpoint

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