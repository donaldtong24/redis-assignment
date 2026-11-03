output "vpc_id" {
  description = "ID of the Redis assignment VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = { for name, subnet in aws_subnet.public : name => subnet.id }
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = { for name, subnet in aws_subnet.private : name => subnet.id }
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway, if enabled"
  value       = try(aws_nat_gateway.main[0].id, null)
}
