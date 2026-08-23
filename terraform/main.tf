
module "ecr" {
  source = "./modules/ecr"
}

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
  depends_on = [ module.iam ]
}

module "ecs" {
  source = "./modules/ecs"
  ecr_repo_url = module.ecr.ecr_repo_url
  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  public_subnet = module.vpc.public_subnet
  security_group = module.vpc.security_group
  depends_on = [ module.ecr, module.iam ]
}

