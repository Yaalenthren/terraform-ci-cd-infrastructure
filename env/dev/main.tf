terraform {
  backend "s3" {
    bucket         = "yaazhan-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

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

module "budget" {
  source = "../../modules/budget"
}

module "cost_reports" {
  source = "../../modules/cost_reports"
}

output "instance_public_ip" {
  value = module.ec2.public_ip
}