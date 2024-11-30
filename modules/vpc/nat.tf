
resource "aws_nat_gateway" "nat" {
  count         = min(var.number_of_nat, length(data.aws_availability_zones.available.names))
  allocation_id = aws_eip.nat[count.index % var.number_of_nat].id
  subnet_id     = aws_subnet.public[count.index % length(aws_subnet.public)].id
  tags = {
    Name = format("%s-%s-%s-nat-gateway-%d", var.tags["environment"], var.tags["project"], var.tags["owner"], count.index + 1)
  }
}

