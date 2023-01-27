resource "aws_security_group" "alb" {
  name        = "alb_ecs"
  description = "Allow ALB to traffic"
  vpc_id      = module.vpc.vpc_id


}

resource "aws_security_group_rule" "tpc_alb" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "tpc_alb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}