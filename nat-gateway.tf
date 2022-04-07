resource "aws_eip" "elastic-ip" {
  vpc                       = true
  associate_with_private_ip = var.eip_private_ip
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.elastic-ip.allocation_id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.name}-${var.public_subnet_id}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # depends_on = [aws_internet_gateway.example]
}

resource "aws_route_table" "route-table" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

}

resource "aws_route_table_association" "route-table-association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.route-table.id
}