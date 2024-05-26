module "aws-prd" {
  source = "../../infla"
  instance_t = "t2.micro"
  enviroment_team = "production"
  group_name = "prd_group"
  group_min = 1
  group_max = 3
}