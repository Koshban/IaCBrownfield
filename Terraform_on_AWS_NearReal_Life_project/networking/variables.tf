##################################################################################
# Optional VARIABLES as these have reasonable defaults provided
##################################################################################

variable "aws_region" {
  type        = string
  default     = "ap-southeast-1"
  description = "Default AWS region to deploy to"
}
##################################################################################
# Optional VARIABLES as these have reasonable defaults
##################################################################################
variable "consul_address" {
  type        = string
  description = "Address of Consul server"
  default     = "127.0.0.1"
}

variable "consul_port" {
  type        = number
  description = "Port Consul server is listening on"
  default     = "8500"
}

variable "consul_datacenter" {
  type        = string
  description = "Name of the Consul datacenter"
  default     = "dc1"
}
