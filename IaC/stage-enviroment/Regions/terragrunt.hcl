# Variables compartidas
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "terragrunt1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
  provider "aws" {
    region = "us-east-1"
    profile = "default"

}
EOF
}

#inputs = {
 # regions = ["us-east-1", "eu-west-1", "eu-west-1"] # Lista de regiones
 # cidr_blocks = "10.0.0.0/16" # Lista de ips
  #availability_zones = ["${local.regions}a", "${local.regions}b", "${local.regions}c" ] # Lista de ips
 # environment = "dev"

#}
