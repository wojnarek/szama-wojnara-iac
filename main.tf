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
  private_subnet_ids = module.network.vm_priavte_subnets_ids
  backend_sg_ids = module.vm_instaces.backend_sg_ids

}

module "vm_instaces" {
  source         = "./modules/ec2"
  sg_name        = "app-sg"
  public_subnet  = [module.network.vm_public_subnets_ids[0]]
  private_subnet = [module.network.vm_priavte_subnets_ids[0]]
  vm_name        = "app-vm"
  vpc_id_for_vm  = module.network.vpc_id
  ami_image = "ami-0087a01c216f83e35"
  instance_profile_ec2_ecr = module.roles.ec2_ecr_profile

}

module "alb" {
  source               = "./modules/alb"
  vpc_for_alb_id       = module.network.vpc_id
  backend_port         = 8081
  frontend_port        = 80
  public_subnets_ids   = module.network.vm_public_subnets_ids
  backend_instance_id  = module.vm_instaces.backend_vm_id_for_alb
  frontend_instance_id = module.vm_instaces.frontend_vm_id_for_alb

}

module "ecr" {
  source = "./modules/ecr"  
}

module "roles" {
  source = "./modules/roles"
  
}