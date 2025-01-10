resource "aws_secretsmanager_secret" "secrets" {
  for_each = toset(var.secrets) 

  name = format(
    "%s-%s-%s-%s",
    var.tags["environment"],
    var.tags["project"],
    var.tags["owner"],
    each.value
  )

  tags = var.tags
}
