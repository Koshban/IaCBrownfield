##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
# Amazon Linux Instance with t2.micro
resource "aws_instance" "nginx" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.aws_def_instance
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)] # % to distribute the instances evenly amongst the total number of subnets
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = module.web_app_s3.instance_profile.name
  depends_on             = [module.web_app_s3] # Because needs the Policy to be applied else can't use the S3 bucket to log

  user_data = templatefile("${path.module}/startupscript.sh", { s3_bucket_name = module.web_app_s3.web_bucket.id })

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-instance"
  })
}

