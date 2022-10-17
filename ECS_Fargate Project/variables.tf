variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "region where resources will be created"
}

variable "cidr_block" {
  type        = string
  default     = "10.1.0.0/16"
  description = "CIDR block of vpc"
}

variable "aws_secret_key" {
  type        = string
  description = "IAM credentials"
  sensitive   = true
}

variable "aws_access_key" {
  type        = string
  description = "IAM credentials"
  sensitive   = true
}

variable "app_image" {
  default     = "centos:latest"
  description = "docker image to run ecs cluster"
}

