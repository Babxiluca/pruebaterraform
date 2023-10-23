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
  region     = "us-east-1"
  access_key = "AKIAWKTWSO4ODMRLUYXJ"
  secret_key = "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"
}

locals {
  availability_zones = ["${var.region}a", "${var.region}b"]
<<<<<<< HEAD
}
=======
}
>>>>>>> main
