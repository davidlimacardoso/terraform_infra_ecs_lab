## terraform_infra_ecs_lab

<h3>Login ECR Repository</h3>
aws ecr get-login-password --region us-east-1 --profile {profile_name} | docker login --username AWS --password-stdin {account_id}.dkr.ecr.{region}.amazonaws.com

<h3>Up Docker Image</h3>
docker push {account_id}.dkr.ecr.{region}.amazonaws.com/{repository_name}

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply