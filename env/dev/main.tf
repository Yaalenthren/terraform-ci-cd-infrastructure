provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source = "../../modules/ec2"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
}

output "instance_public_ip" {
  value = module.ec2.public_ip
}