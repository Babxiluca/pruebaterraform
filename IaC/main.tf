data "aws_availability_zones" "available" {

}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vpc-${var.environment}"
  cidr = var.cidr_block


  azs                 = local.availability_zones
  private_subnets     = [cidrsubnet(var.cidr_block, 3, 0), cidrsubnet(var.cidr_block, 3, 1)]
  private_subnet_tags = { Name = "private" }
  public_subnets      = [cidrsubnet(var.cidr_block, 3, 3), cidrsubnet(var.cidr_block, 3, 4)]
  public_subnet_tags  = { Name = "public" }

  enable_dns_support            = true
  enable_dns_hostnames          = true
  enable_nat_gateway            = true
  one_nat_gateway_per_az        = true
  create_igw                    = true
  manage_default_security_group = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
