resource "aws_lb" "alb" {
  name               = "ecs-django"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [module.vpc.public_subnets]
}