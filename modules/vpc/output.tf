output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.public[*].id
}

# Output private subnet names (instead of subnet IDs)
output "private_subnet_names" {
  description = "List of private subnet names"
  value       = aws_subnet.private[*].tags["Name"]  # Output the subnet names
}

output "vpc_id" {
  description = "List of private subnet names"
  value       = aws_vpc.main.id # Output the subnet names
}
