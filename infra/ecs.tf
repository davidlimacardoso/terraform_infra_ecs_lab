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

  resource "aws_ecs_task_definition" "name-prd-tsk" {
    family                   = "django-api"
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = aws_iam_role.ecs_role.arn 
    container_definitions    = jsonencode(
        [
            {
                "name" = var.ambient
                "image" = "docker push ${var.account}.dkr.ecr.us-east-1.amazonaws.com/nginx-hello/server"
                "cpu" = 256
                "memory" = 512
                "essential" = true
                "portMappings" = [
                    {
                    "containerPort" = 8000
                    "hostPort"      = 8000
                    }
                ]
            }
        ]
    )
    }

  tags = {
    Terraform = "true"
    Environment = "prd"
  }
} 