module "aws-dev" {
  source = "../../infla"
  instance_t = "t2.micro"
  enviroment_team = "development"
}

output "IP_DEV" {
  value = module.aws-dev.IP_Public
}