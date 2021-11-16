# 10.0.0.0/16 VPC 전용 Internet Gateway
resource "aws_internet_gateway" "chlee_ig" {
  vpc_id = aws_vpc.chlee_vpc.id

  tags = {
    "Name" = "${var.name}ig"
  }
}

resource "aws_route_table" "chlee_rt" {
  vpc_id = aws_vpc.chlee_vpc.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.chlee_ig.id
  }
  tags = {
    "Name" = "${var.name}-rt"
    }
}

resource "aws_route_table_association" "chlee_rtas_a"{
  count = length(var.cidr_public)
  subnet_id = aws_subnet.chlee_pub[count.index].id
  route_table_id = aws_route_table.chlee_rt.id
}

