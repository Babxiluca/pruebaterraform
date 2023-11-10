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
  region            = "us-east-2"
  cidr       = include.env.locals.cidr
  azs             = include.env.locals.azs
  private_subnets = [cidrsubnet(include.env.locals.cidr, 3, 0), cidrsubnet(include.env.locals.cidr, 3, 1)]
  public_subnets  = [cidrsubnet(include.env.locals.cidr, 3, 2), cidrsubnet(include.env.locals.cidr, 3, 3)]
  environment       = include.env.locals.env
}
