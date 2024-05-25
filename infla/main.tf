terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.regiao_aws
  shared_config_files      = ["/home/user/.aws/config"]
  shared_credentials_files = ["/home/user/.aws/credentials"]
}

resource "aws_instance" "app_server" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = var.instance_t
  key_name      = "iac_alura"

  tags = {
    Name = "Aws Instance ${var.enviroment_team}_1"
  }
}

output "IP_Public" {
  value = aws_instance.app_server.public_ip
  description = "Return IP Public from instance"
}

# Exemplo usar chave pub criada com ssh-keygen e vincular a Aws
# resource "aws_key_pair" "chaveSSH" {
#   key_name = “Nome da chave”
#   public_key = file("${var.chave}.pub")
# }