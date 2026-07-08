############################################
# Project
############################################

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

############################################
# Network
############################################

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private Application Subnet IDs"
  type        = list(string)
}

############################################
# ECS Cluster
############################################

variable "cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

############################################
# Container
############################################

variable "container_name" {
  description = "Container Name"
  type        = string
}

variable "container_image" {
  description = "Docker Image"
  type        = string
}

variable "container_port" {
  description = "Container Port"
  type        = number
  default     = 80
}

############################################
# ECS Task
############################################

variable "cpu" {
  description = "Task CPU"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task Memory"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired Task Count"
  type        = number
  default     = 2
}

############################################
# Health Check
############################################

variable "health_check_path" {
  description = "ALB Health Check Path"
  type        = string
  default     = "/"
}

############################################
# Load Balancer
############################################

variable "listener_port" {
  description = "ALB Listener Port"
  type        = number
  default     = 80
}

############################################
# CloudWatch
############################################

variable "log_retention_days" {
  description = "CloudWatch Log Retention"
  type        = number
  default     = 7
}

############################################
# Auto Scaling
############################################

variable "enable_autoscaling" {
  description = "Enable ECS Auto Scaling"
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Minimum Tasks"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Maximum Tasks"
  type        = number
  default     = 5
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