module "aws-dev" {
  source = "../../infla"
  instance_t = "t2.micro"
  enviroment_team = "development"
  group_name = "dev_group"
  group_min = 0
  group_max = 1
}