terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
    region = "eu-central-1"
    profile = "default"
  
}

module "network" {

    source = "./modules/network"
    vpc_name = "app_vpc"
    subnet_name = "app_subnet"
    public_subnet_cidrs = ["10.0.1.0/24","10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.3.0/24","10.0.4.0/24"]
    destination_for_public_route = "0.0.0.0/0"
}