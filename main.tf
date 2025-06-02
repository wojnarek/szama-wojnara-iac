terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "default"

}

module "network" {

  source                       = "./modules/network"
  vpc_name                     = "app_vpc"
  public_subnet_cidrs          = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs         = ["10.0.3.0/24", "10.0.4.0/24"]
  destination_for_public_route = "0.0.0.0/0"

}

module "vm_instaces" {
  source = "./modules/ec2"
  sg_name = "app-sg"
  public_subnet = [module.network.vm_public_subnets_ids[0]]
  private_subnet = [module.network.vm_priavte_subnets_ids[0]]
  vm_name = "app-vm"
  vpc_id_for_vm = module.network.vpc_id

}