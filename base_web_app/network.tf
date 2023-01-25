##################################################################################
# MODULE
##################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "=3.19.0"
  cidr    = var.vpc_cidr_block

  azs            = slice(data.aws_availability_zones.available.names, 0, (var.vpc_subnet_count))
  public_subnets = [for subnet in range(var.vpc_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}
##################################################################################
# DATA
##################################################################################
data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "${local.name_prefix}-nginx-sg"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] # Only Allow traffic from VPC as External Facing will be handled by the ALB
  }
  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name   = "${local.name_prefix}-alb-sg"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3
## Bucket Creation
resource "aws_s3_bucket" "terraform_state" {
  bucket = "kaushikb-terraform-s3-state"
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-s3-terraform-state"
  })
  # Mitigate accidental deletion
  lifecycle {
    prevent_destroy = false # true when actually using it to store TF state files for team consumption      
  }
}

## Block all public Access, as an added safety ( by default public access is blocked but its to ensure access is not granted by mistake)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}





