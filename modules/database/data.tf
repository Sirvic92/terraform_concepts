# Define the Secrets Manager data resources first
data "aws_secretsmanager_secret" "db_secret" {
  name = "dev-learning-Victor-db_secret"
}

data "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}
