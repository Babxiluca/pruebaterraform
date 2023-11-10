
data "aws_region" "current" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  
  name = "vpc-${var.environment}"
  cidr = var.cidr

  azs = ["${var.region}a", "${var.region}b"]


  private_subnets = [cidrsubnet(var.cidr, 3, 0), cidrsubnet(var.cidr, 3, 1)]
  public_subnets  = [cidrsubnet(var.cidr, 3, 2), cidrsubnet(var.cidr, 3, 3)]

  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  create_igw             = true

  manage_default_security_group = false





  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block]
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

#azs  = var.environment == "dev" || var.environment == "stage" ? local.dev_region : local.prod_region
#cidr = var.environment == "dev" || var.environment == "stage" ? element(var.cidr_block, 0) : element(var.cidr_block, index(var.regions, var.environment))
#cidr = var.cidr_block[var.environment == "dev" || var.environment == "stage" ? 0 : index(var.regions, var.environment)]


#private_subnets = var.environment == "dev" || var.environment == "stage" ? [cidrsubnet(element(var.cidr_block, 0), 3, 0), cidrsubnet(element(var.cidr_block, 0), 3, 1)] : [cidrsubnet(element(var.cidr_block, 0), 3, 3), cidrsubnet(element(var.cidr_block, 0), 3, 1), cidrsubnet(element(var.cidr_block, 0), 3, 2)]
#public_subnets  = var.environment == "dev" || var.environment == "stage" ? [cidrsubnet(element(var.cidr_block, 0), 3, 2), cidrsubnet(element(var.cidr_block, 0), 3, 3)] : [cidrsubnet(element(var.cidr_block, 0), 3, 4), cidrsubnet(element(var.cidr_block, 0), 3, 5), cidrsubnet(element(var.cidr_block, 0), 3, 6)]

#cidr_block = cidrsubnet(aws_vpc.example.cidr_block, 4, var.az_number[data.aws_availability_zone.example.name_suffix])


# Create a subnet for the AZ within the regional VPC


#flatten([
# for idx, region in var.regions :
#[
# for az in data.aws_availability_zones.available[region].names :
#var.environment == "dev" || var.environment == "stage" ? [
# "${region}${az}a",
#"${region}${az}b"
#] : [
#"${region}${az}a",
#"${region}${az}b",
#"${region}${az}c"
#]
#]
#]#)


#azs = var.environment == "dev" ? local.dev_region : local.prod_region
#private_subnets = var.environment == "dev" ? [cidrsubnet(var.cidr_block, 3, 0), cidrsubnet(var.cidr_block, 3, 1)] : [cidrsubnet(var.cidr_block, 3, 0), cidrsubnet(var.cidr_block, 3, 1), cidrsubnet(var.cidr_block, 3, 2)]
#private_subnets = [cidrsubnet(var.cidr_block, 3, 0),cidrsubnet(var.cidr_block, 3, 1)]
#private_subnet_tags = { tier = private }
#public_subnets  = var.environment == "dev" ? [cidrsubnet(cidr, 3, 2), cidrsubnet(cidr, 3, 3)] : [cidrsubnet(cidr, 3, 3), cidrsubnet(cidr, 3, 4), cidrsubnet(cidr, 3, 5)]





#public_subnets = var.environment == "dev" || var.environment == "stage" ? [cidrsubnet(element(var.cidr_block,0), 3, 2), cidrsubnet(element(var.cidr_block,0), 3, 3)] : [cidrsubnet(var.cidr_block, 3, 4), cidrsubnet(var.cidr_block, 3, 5), cidrsubnet(var.cidr_block, 3, 6)]
#public_subnet_tags  = { tier = public }

