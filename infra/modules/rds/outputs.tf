############################################
# RDS Instance
############################################

output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS Instance ARN"
  value       = aws_db_instance.this.arn
}

output "db_identifier" {
  description = "Database Identifier"
  value       = aws_db_instance.this.identifier
}

############################################
# Database Connection
############################################

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.this.db_name
}

output "db_endpoint" {
  description = "Database Endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "Database Address"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "Database Port"
  value       = aws_db_instance.this.port
}

output "db_username" {
  description = "Database Username"
  value       = aws_db_instance.this.username
  sensitive   = true
}

############################################
# Networking
############################################

output "security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds.id
}

output "db_subnet_group_name" {
  description = "DB Subnet Group Name"
  value       = aws_db_subnet_group.this.name
}

output "parameter_group_name" {
  description = "DB Parameter Group Name"
  value       = aws_db_parameter_group.this.name
}

############################################
# Monitoring
############################################

output "monitoring_role_arn" {
  description = "Enhanced Monitoring Role ARN"
  value       = aws_iam_role.rds_monitoring.arn
}

############################################
# Database Information
############################################

output "engine" {
  description = "Database Engine"
  value       = aws_db_instance.this.engine
}

output "engine_version" {
  description = "Database Engine Version"
  value       = aws_db_instance.this.engine_version
}

output "instance_class" {
  description = "RDS Instance Class"
  value       = aws_db_instance.this.instance_class
}

############################################
# Backup
############################################

output "backup_retention_period" {
  description = "Backup Retention Period"
  value       = aws_db_instance.this.backup_retention_period
}

############################################
# Availability
############################################

output "availability_zone" {
  description = "Availability Zone"
  value       = aws_db_instance.this.availability_zone
}

output "multi_az" {
  description = "Multi AZ Enabled"
  value       = aws_db_instance.this.multi_az
}

############################################
# Storage
############################################

output "allocated_storage" {
  description = "Allocated Storage (GB)"
  value       = aws_db_instance.this.allocated_storage
}

output "storage_encrypted" {
  description = "Storage Encryption Status"
  value       = aws_db_instance.this.storage_encrypted
}