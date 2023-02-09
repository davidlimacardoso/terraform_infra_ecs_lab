module "prod" {
    source = "../../infra"
    repository_name = "production"
    ecs_role = "prd"
    ambient = "production"
    account = "88888888888"
}

output "ip_alb" {
    value = module.prod.ip
}