resource "aws_vpc_endpoint" "ecr_api" {
    vpc_id = aws_vpc.app_vpc.id
    service_name = "com.amazonaws.eu-central-1.ecr.api"
    vpc_endpoint_type = "Interface"
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.backend_sg_ids]
}

resource "aws_vpc_endpoint" "ecr_dkr" {
    vpc_id = aws_vpc.app_vpc.id
    service_name = "com.amazonaws.eu-central-1.ecr.dkr"
    vpc_endpoint_type = "Interface"
    subnet_ids = var.private_subnet_ids
    security_group_ids = [var.backend_sg_ids]
  
}