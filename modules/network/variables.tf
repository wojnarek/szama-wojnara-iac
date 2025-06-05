variable "vpc_name" {
  type        = string
  description = "VPC name"
  default     = "app_vpc "
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for vpc"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnet"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnet"
}

variable "destination_for_public_route" {
  type = string

}

variable "private_subnet_ids" {
  type = list(string)
  
}

variable "backend_sg_ids" {
 type = string 
}