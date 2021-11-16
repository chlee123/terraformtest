resource "aws_eip" "chlee_eip_ng" {
  vpc = true
}

resource "aws_nat_gateway" "chlee_ng"{
  allocation_id = aws_eip.chlee_eip_ng.id
subnet_id = aws_subnet.chlee_pub[0].id
tags = {
  "Name" = "${var.name}-ng"
}
depends_on = [
  aws_internet_gateway.chlee_ig
]
}

resource "aws_route_table" "chlee_ngrt" {
  vpc_id = aws_vpc.chlee_vpc.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.chlee_ng.id
  }

  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

resource "aws_route_table_association" "chlee_ngass" {
count = length(var.cidr_public)
subnet_id = aws_subnet.chlee_pri[count.index].id
route_table_id = aws_route_table.chlee_ngrt.id
} 