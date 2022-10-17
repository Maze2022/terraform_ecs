
resource "aws_vpc" "ecs_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "ecs_vpc"
  }
}

# Declare the data source for AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Create subnets in the first two available availability zones
resource "aws_subnet" "Private_subnet_2a" {
  count                   = 1
  cidr_block              = "10.1.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.ecs_vpc.id
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_subnet_2a"
  }
}

resource "aws_subnet" "Private_subnet_2b" {
  count                   = 1
  cidr_block              = "10.1.16.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.ecs_vpc.id
  map_public_ip_on_launch = false

  tags = {
    Name = "Private_subnet_2b"
  }
}
