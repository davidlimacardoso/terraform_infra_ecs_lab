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

  resource "aws_ecs_task_definition" "django-api" {
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

resource "aws_ecs_service" "django-api" {
  name            = "django-api"
  cluster         = module.ecs.ecs_cluster.id
  task_definition = aws_ecs_task_definition.django-api.arn
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.target.arn
    container_name   = var.ambient
    container_port   = 8000
  }
}

network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.private.id] 

}

capacity_provider_strategy {
    capacity_provider   = "FARGATE"
    weight = 1 
}

  tags = {
    Terraform = "true"
    Environment = "prd"
  }
} 