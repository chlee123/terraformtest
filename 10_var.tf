variable "name" {
  type = string
  default = "chlee"
}

variable "region" {
  type = string
  default = "ap-northeast-2"
}

variable "ava" {
  type = list(string)
  default = ["a","c"]
}

variable "key" {
  type = string
  default = "chlee2-key"
}

variable "cidr_main" {
  type = string
  default = "10.0.0.0/16"
}

variable "cidr_public" {
  type = list(string)
  default = ["10.0.0.0/24","10.0.2.0/24"]
}

variable "cidr_private" {
  type = list(string)
  default = [ "10.0.1.0/24","10.0.3.0/24" ]
}

variable "cidr_privatedb" {
  type = list(string)
  default = [ "10.0.4.0/24","10.0.5.0/24" ]
}

variable "cidr_route" {
  type = string
  default = "0.0.0.0/0"
}

variable "port_http" {
  type = number
  default = 80
}

variable "protocol_tcp" {
  type = string
  default = "tcp"
}

variable "protocol_http" {
  type = string
  default = "HTTP"
}

variable "port_ssh" {
  type = number
  default = 22
}

variable "port_sql" {
  type = number
  default = 3306
}

variable "port_icmp" {
  type = number
  default = 0
}

variable "ipv6" {
    type = string
    default = "::/0" 
}

variable "port" {
  type = number
  default = 0
}
variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "private_ip" {
    type = string
    default = "10.0.0.11"
}

variable "db_engine" {
    type = string
    default = "mysql"
}

variable "db_version" {
    type = string
    default = "8.0"
}

variable "db_name_inentifier" {
    type = string
    default = "test"
}