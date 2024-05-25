module "aws-prd" {
  source = "../../infla"
  instance_t = "t2.micro"
  enviroment_team = "production"
}

output "IP_PROD" {
  value = module.aws-prd.IP_Public
}