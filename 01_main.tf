provider  "aws" {
    region = var.region
}

resource "aws_key_pair" "chlee_key" {
  key_name = var.key
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCy90MZg4S0i2JkAjBl2YJOlVPCQycDygLlLAf8cYZHq2jg93M0NywrxvUnEnpY0lh3OdlUWlCyo5prm0ox6WGlw0DXCZIsDkC3DXikG1/2g5lrecVMkiVN8OdqDyr4MBYKYQk7Lw0+e4QYL1wRTskqp5DcaB2Y2IUtniLd0ClEPxij8dzyEcVT/IN6AK/R4FCyk01j/lJsr1JWkhd7URYhjYiDBLAN0WeYNhilrudjrx+Z71dODA/Hky5mBDCz667qRJ9fV03lQE7+HeybUaLlZjX6UIHnKSF1pGAwfjCQbqw+XX+oZ8iYLH1AYyk9EH53xBEKsZxXc4sjnWJn4M67QiawuaOsPOXdwPZGsj8FRDr86ful2YCMcU9ZcLiSiHuQ13KaYySIccOmJ8v+VPj01FSimM/SYwwMKQhe3DZ0cugG6i2pQ2X/tfk0Uv8PucQU8BKtj8X6hL4gvQ80/VBAsdRMJsgjWPStD9eBUTKPW49HaCpQkjde/sigaPVzUFE= user@LAPTOP-CISI8I61"
public_key = file("../../.ssh/chlee-key.pub")
}

resource "aws_vpc" "chlee_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "key" = "${var.name}-vpc"
  }
}
#가용영역 public subnet
resource "aws_subnet" "chlee_pub" {
    count = length(var.cidr_public) #2
  vpc_id = aws_vpc.chlee_vpc.id
  cidr_block = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}

#가용영역 private subnet
resource "aws_subnet" "chlee_pri" {
    count = length(var.cidr_private)
  vpc_id = aws_vpc.chlee_vpc.id
  cidr_block = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pub${var.ava[count.index]}"
  }
}


#가용영역 private db subnet
resource "aws_subnet" "chlee_pridb" {
    count = length(var.cidr_privatedb)
  vpc_id = aws_vpc.chlee_vpc.id
  cidr_block = var.cidr_privatedb[count.index]
  availability_zone = "${var.region}${var.ava[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava[count.index]}"
  }
}

