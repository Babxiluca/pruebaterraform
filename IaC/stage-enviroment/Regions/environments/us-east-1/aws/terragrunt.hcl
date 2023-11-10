terraform {
  source = "../../../../modules/vpc"
}

# Automatically find the root terragrunt.hcl and inherit its configuration
include "root"{
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  name              = "vpc"
  region            = "us-east-1"
  cidr              = include.env.locals.cidr
  azs             = include.env.locals.region
  private_subnets = [cidrsubnet(include.env.locals.cidr, 3, 0), cidrsubnet(include.env.locals.cidr, 3, 1)]
  public_subnets  = [cidrsubnet(include.env.locals.cidr, 3, 2), cidrsubnet(include.env.locals.cidr, 3, 3)]
  environment       = include.env.locals.env
  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  create_igw             = true

  manage_default_security_group = false
}
