variable "aws_region" {

  description = "AWS Region"

  type = string

}


variable "environment" {

  description = "Environment"

  type = string

}


variable "project_name" {

  description = "Project Name"

  type = string

}


variable "vpc_cidr" {

  type = string

}


variable "availability_zones" {

  type = list(string)

}


variable "public_subnet_cidrs" {

  type = list(string)

}


variable "private_app_subnet_cidrs" {

  type = list(string)

}


variable "private_db_subnet_cidrs" {

  type = list(string)

}


variable "container_image" {

  type = string

}


variable "container_port" {

  type = number

}


variable "db_name" {

  type = string

}


variable "db_username" {

  type = string

}


variable "db_password" {

  type = string

  sensitive = true

}