terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

locals {
  any_host           = ["0.0.0.0/0"]
  node_exporter_port = "9100"
}

resource "aws_security_group" "firewall" {
  name = var.name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = local.any_host
  }

  ingress {
    from_port   = local.node_exporter_port
    to_port     = local.node_exporter_port
    protocol    = "tcp"
    cidr_blocks = local.any_host
  }
}

resource "aws_instance" "vm" {
  ami                    = var.ami_code
  instance_type          = "a1.xlarge"
  vpc_security_group_ids = [aws_security_group.firewall.id]

  tags = {
    Name    = var.name
    Project = "tcc-elayne"
  }
}
