resource "aws_db_instance" "chlee_rds" {
  allocated_storage =20
  storage_type ="gp2"
  engine = var.db_engine
  engine_version = var.db_version
  instance_class = "db.t2.micro"
  name = var.db_name_inentifier
  identifier = var.db_name_inentifier
  username = "admin"
  password = "Dlckdgns123!"
  parameter_group_name = "default.mysql8.0"
  availability_zone = "ap-northeast-2a"
  db_subnet_group_name = aws_db_subnet_group.chlee_dbsb.id 
  vpc_security_group_ids = [aws_security_group.chlee_sg.id]
  skip_final_snapshot = true
  tags = {
    "Name" = "${var.name}_rds"
  }
}

resource "aws_db_subnet_group" "chlee_dbsb" {
  name = "${var.name}-dbsb-group"
  subnet_ids = aws_subnet.chlee_pridb[*].id
  tags = {
    "Name" = "${var.name}-dbsb-gp"
  }
}