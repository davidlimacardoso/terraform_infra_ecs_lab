module "prod" {
    source = "../../infra"
    repository_name = "production"
    ecs_role = "prd"
}

output "ip_alb" {
    value = module.prod.ip
}