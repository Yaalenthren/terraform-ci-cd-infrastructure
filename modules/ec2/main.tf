variable "vpc_id" {}
variable "subnet_id" {}

resource "aws_security_group" "dev_sg" {
  name   = "dev-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "dev_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    aws_security_group.dev_sg.id
  ]

  tags = {
    Name = "terraform-ci-instance"
  }
}