module "prod" {
    source = "../../infra"
    repository_name = "production"
    ecs_role = "prd"
}