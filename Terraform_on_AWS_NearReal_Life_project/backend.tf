# Backend to link storing TF State in S3 and DynamoDB
# terraform {
#   backend "s3" {
#     bucket = "kaushikb-terraform-s3-state"  # Your S3 bucket name
#     key     = "base_web_app/terraform.tfstate"  # The filepath within the S3 bucket where the Terraform state file should be written
#     encrypt = true
#     # profile = "credentials"
#     profile = "deep-dive"
#   }
# }

terraform {
  backend "consul" {
    address = "127.0.0.1:8500"
    scheme  = "http"
  }
}