############################################
# Project Information
############################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
}

############################################
# Network
############################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "Private Database Subnet IDs"
  type        = list(string)
}

variable "allowed_security_groups" {
  description = "Security Groups allowed to access RDS"
  type        = list(string)
  default     = []
}

############################################
# Database Configuration
############################################

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_username" {
  description = "Master Username"
  type        = string
}

variable "db_password" {
  description = "Master Password"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "Database Engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "PostgreSQL Engine Version"
  type        = string
  default     = "16.3"
}

variable "instance_class" {
  description = "RDS Instance Class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated Storage (GB)"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum Storage"
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Storage Type"
  type        = string
  default     = "gp3"
}

############################################
# High Availability
############################################

variable "multi_az" {
  description = "Enable Multi AZ"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Public Access"
  type        = bool
  default     = false
}

############################################
# Backup
############################################

variable "backup_retention_period" {
  description = "Backup Retention"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup Window"
  type        = string
  default     = "02:00-03:00"
}

variable "maintenance_window" {
  description = "Maintenance Window"
  type        = string
  default     = "Sun:03:00-Sun:04:00"
}

############################################
# Monitoring
############################################

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring Interval"
  type        = number
  default     = 60
}

############################################
# Encryption
############################################

variable "storage_encrypted" {
  description = "Enable Storage Encryption"
  type        = bool
  default     = true
}

############################################
# Deletion Protection
############################################

variable "deletion_protection" {
  description = "Deletion Protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip Final Snapshot"
  type        = bool
  default     = true
}

############################################
# Parameter Group
############################################

variable "family" {
  description = "DB Parameter Group Family"
  type        = string
  default     = "postgres16"
}

############################################
# Tags
############################################

variable "tags" {
  description = "Common Tags"

  type = map(string)

  default = {
    Terraform = "true"
  }
}