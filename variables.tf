variable "environment" {
  description = "Environment (dev, stage, prod)"
  type        = string
}

variable "region" {
  type        = string
  description = "List of regions for the environment"
}


variable "cidr_block" {
  description = "range of Ips"
  type        = string
}