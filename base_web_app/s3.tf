module "web_app_s3" {
  source = "./modules/kaushikb-webapp-s3"

  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}
resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}
resource "aws_s3_object" "website_content" {
  for_each = {
    website = "/WebSite/index.html"
    logo    = "/WebSite/TechDebt.PNG"
  }
  bucket     = module.web_app_s3.web_bucket.id
  key        = each.value
  source     = ".${each.value}"
  kms_key_id = aws_kms_key.examplekms.arn
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-s3-object-${each.value}"
  })
}


