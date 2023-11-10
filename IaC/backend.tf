terraform {
  backend "s3" {
    bucket = "preubaalba"
    key    = "Desarrollo.terraform.tfstate"
    region = "us-east-1"

  }
}