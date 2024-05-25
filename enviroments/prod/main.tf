module "aws-dev" {
  source = "../../infla"
  instance_t = "t2.micro"
  enviroment_team = "production"
}

output "IP_PROD" {
  value = module.aws-dev.IP_Public
}