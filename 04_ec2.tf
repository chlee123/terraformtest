resource "aws_security_group" "chlee_sg" {
  name = "Allow Basic"
  description = "Allow HTTP,SSH,SQL,ICMP"
  vpc_id = aws_vpc.chlee_vpc.id

  ingress =[
    {
      description = "Allow HTTP"
      from_port = var.port_http
      to_port   = var.port_http
      protocol  = var.protocol_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6]
      prefix_list_ids = null
      security_groups = null
      self = null
  },
  {
      description = "Allow SSH"
      from_port = var.port_ssh
      to_port   = var.port_ssh
      protocol  = var.protocol_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6]
      prefix_list_ids = null
      security_groups = null
      self = null
  },
  {
      description = "Allow SQL"
      from_port = var.port_sql
      to_port   = var.port_sql
      protocol  = var.protocol_tcp
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6]
      prefix_list_ids = null
      security_groups = null
      self = null
  },
  {
      description = "Allow ICMP"
      from_port = var.port_icmp
      to_port   = var.port_icmp
      protocol  = "icmp"
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6]
      prefix_list_ids = null
      security_groups = null
      self = null
  }
  ]
  egress = [
    {
      description = "ALL"
      from_port = var.port
      to_port =var.port
      protocol = -1
      cidr_blocks = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6]
      prefix_list_ids = null
      security_groups = null
      self = null
      }
  ]
  tags = {
    "Name" = "${var.name}-sg"
  }
#lifecycle {
#    create_before_destroy = true
#  }
}


/*data "aws_ami" "amzn" {
  most_recent = 

  filter {
    name = "name"
    valus = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
*/


resource "aws_instance" "chlee_web" {
  ami = "ami-04e8dfc09b22389ad"
  instance_type = var.instance_type
  key_name = var.key
  availability_zone = "${var.region}${var.ava[0]}"
  private_ip = var.private_ip
  subnet_id = aws_subnet.chlee_pub[0].id
  vpc_security_group_ids = [aws_security_group.chlee_sg.id]
  user_data = file("./install.sh")
              #<<-EOF
              #!/bin/bash
              #sudo su -
              #yum install -y httpd
              #echo "CHLEE-Terraform-1" >> /var/www/html/index.html
              #systemctl start httpd
              #EOF
}

resource "aws_eip" "chlee_web_ip" {
  vpc = true
  instance = aws_instance.chlee_web.id
  associate_with_private_ip = var.private_ip
  depends_on = [
    aws_internet_gateway.chlee_ig
  ]
}

output "public_ip" {
  value = aws_instance.chlee_web.public_ip
}
