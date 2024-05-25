variable "regiao_aws" {
    type = string
    default = "us-east-1"
}   

variable "instance_t" {
  type = string
}

variable "enviroment_team" {
  type = string
  description = "Enviroment of team, example Prod, Development, QA"
}