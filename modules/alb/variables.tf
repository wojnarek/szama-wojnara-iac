variable "vpc_for_alb_id" {
  type = string

}

variable "public_subnets_ids" {
  type = list(string)
}

variable "frontend_port" {
  type = number
}

variable "backend_port" {
  type = number
}

variable "frontend_instance_id" {
  type = string

}

variable "backend_instance_id" {
  type = string

}