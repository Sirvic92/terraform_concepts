resource "aws_subnet" "public" {
  count      = var.no_public_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, var.subnet_bits, count.index)

  availability_zone = element(data.aws_availability_zones.available.names, count.index % length(data.aws_availability_zones.available.names))

  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-public-subnet-%d", var.tags["environment"], var.tags["project"], var.tags["owner"], count.index + 1)
  })
}


resource "aws_subnet" "private" {
  count      = var.no_private_subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, var.subnet_bits, count.index + var.no_public_subnets)

  availability_zone = element(
    data.aws_availability_zones.available.names,
    count.index % length(data.aws_availability_zones.available.names)
  )

  map_public_ip_on_launch = false

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-private-subnet-%d", var.tags["environment"], var.tags["project"], var.tags["owner"], count.index + 1)
  })
}

