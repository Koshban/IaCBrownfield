##################################################################################
# Optional VARIABLES as these have reasonable defaults provided
##################################################################################

variable "aws_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Default AWS region to deploy to"
}

variable "subnet_count" {
  default     = 2
  type        = number
  description = "Total number of subnets to use"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Base CIDR Block for VPC"
}
##################################################################################
# Mandatory VARIABLES as these have NO defaults
##################################################################################
variable "private_subnets" {
  type = list(any)
}

variable "public_subnets" {
  type = list(any)
}
