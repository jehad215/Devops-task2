resource "aws_route_table" "example_route_table" {
  vpc_id = aws_vpc.example_vpc.id
}

resource "aws_route_table_association" "example_route_table_association" {
  subnet_id = aws_subnet.example_subnet.id
  route_table_id = aws_route_table.example_route_table.id
}

resource "aws_route" "i_g" {
    route_table_id = aws_route_table.example_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
}