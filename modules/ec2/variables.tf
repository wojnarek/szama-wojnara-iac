variable "vm_name" {
  type = string
}

variable "sg_name" {
  type = string

}

variable "vm_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_image" {
  type    = string
}

variable "vpc_id_for_vm" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

variable "private_subnet" {
  type = list(string)
}