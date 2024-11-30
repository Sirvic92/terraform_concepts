
resource "aws_eip" "nat" {
  count = min(var.number_of_nat, length(data.aws_availability_zones.available.names))
  vpc   = true
  tags = {
    Name = format("%s-%s-%s-nat-eip-%d", var.tags["environment"], var.tags["project"], var.tags["owner"], count.index + 1)
  }
}
