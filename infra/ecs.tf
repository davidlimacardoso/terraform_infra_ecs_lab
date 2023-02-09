module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = var.ambient

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = {
    Terraform = "true"
    Environment = "prd"
  }
}