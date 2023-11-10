variable "environment" {
  description = "Environment (dev, stage, prod)"
  type        = string
}

variable "cidr" {
  description = "CIDR block for VPC"
  type        = string
  #default = "10.0.0.0/16"
}

variable "region" {
  description = "Availability zones"
  type = string
  
}


##variable "region_number" {
# Arbitrary mapping of region name to number to use in
# a VPC's CIDR prefix.
#default = {
# us-east-1    = 1
#eu-central-1 = 2
#eu-west-1    = 3
#eu-central-1 = 4
#ap-south-1   = 5
#}
#}

#variable "az_number" {
# Assign a number to each AZ letter used in our configuration
# default = {
#  a = 1
# b = 2
# c = 3
#}
#}