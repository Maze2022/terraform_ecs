terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  # aws_secret_key = "var.aws_secret_key"
  # aws_access_key = "var.aws_access_key"
}