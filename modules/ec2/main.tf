resource "aws_instance" "dev_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-ci-instance"
  }
}
