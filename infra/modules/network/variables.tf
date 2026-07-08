#############################
# Project Information
#############################

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment Name (dev/prod)"
  type        = string
}

#############################
# VPC
#############################

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type        = bool
  default     = true
}

#############################
# Availability Zones
#############################

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

#############################
# Public Subnets
#############################

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)
}

#############################
# Private App Subnets
#############################

variable "private_app_subnet_cidrs" {
  description = "Private Application Subnet CIDRs"
  type        = list(string)
}

#############################
# Private DB Subnets
#############################

variable "private_db_subnet_cidrs" {
  description = "Private Database Subnet CIDRs"
  type        = list(string)
}

#############################
# NAT Gateway
#############################

variable "enable_nat_gateway" {
  description = "Create NAT Gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use Single NAT Gateway"
  type        = bool
  default     = true
}

#############################
# Tags
#############################

variable "tags" {
  description = "Common Resource Tags"
  type        = map(string)

  default = {
    Terraform = "true"
  }
}