terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.16.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.19.0"
    }
  }
}


provider "aws" {
  region = "us-west-2"
}

locals {
  availability_zones = ["${var.region}a", "${var.region}b"]
}
