############################################
# RDS Outputs
############################################

output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.this.arn
}

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "RDS Address"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS Port"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.this.db_name
}

output "db_subnet_group" {
  description = "DB Subnet Group"
  value       = aws_db_subnet_group.this.name
}

output "security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds.id
}
