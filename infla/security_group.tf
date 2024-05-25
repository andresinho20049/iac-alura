resource "aws_security_group" "security_group_global" {
  name = "security_group_terraform_${var.enviroment_team}"
  description = "Security Group for Test Terraform"
  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [ "::/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress{
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [ "::/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  tags = {
    Name = "security_group_terraform_${var.enviroment_team}"
  }
}