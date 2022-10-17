#ECS Cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my_cluster"
}

resource "aws_ecs_cluster_capacity_providers" "my_cluster" {
  cluster_name = aws_ecs_cluster.my_cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }
}

#Module for ECS-Fargate
module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "my_ecs-fargate"
  vpc_id             = aws_vpc.ecs_vpc.id
  private_subnet_ids = [aws_subnet.Private_subnet_2a.id, aws_subnet.Private_subnet_2b.id]

  cluster_id = aws_ecs_cluster.my_cluster.id

  task_container_image   = "var.app_image"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "my_tg-fargate"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project     = "Test"
  }
}

