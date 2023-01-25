output "aws_instance_nginx_public_dns" {
  value       = aws_lb.Nginx-LB.dns_name
  description = "The DNS of the Load Balancer which will be exposed for connections"
  sensitive   = false
}
# output "aws_instance_nginx_ec2_main_public_dns" {
#   value       = aws_instance.nginx[count.index].public_dns
#   description = "The DNS of the Primary Nginx Instance"
#   sensitive   = false
# }
# output "aws_instance_nginx_ec2_main_public_IPs" {
#   value       = aws_instance.nginx[count.index].public_ip
#   description = "The IP Addresses of the Primary Nginx Instance"
#   sensitive   = false
# }
