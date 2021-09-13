# outputs.tf

output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnets" {
  value = aws_subnet.private.*.id
}

output "security_group_lb_id" {
  value = aws_security_group.lb.id
}

output "target_group_arn" {
  value = aws_alb_target_group.app.id
}