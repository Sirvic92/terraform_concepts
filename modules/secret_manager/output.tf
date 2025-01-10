output "secrets_arns" {
  description = "ARNs of the created Secrets Manager secrets"
  value       = { for secret_name, secret in aws_secretsmanager_secret.secrets : secret_name => secret.arn }
}