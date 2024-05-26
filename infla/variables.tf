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

variable "group_name" {
  type = string
}

variable "group_max" {
  type = number
}

variable "group_min" {
  type = number
}