output "vm_public_subnets_ids" {
    value = aws_subnet.public_subnets[*].id
}


output "vm_priavte_subnets_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "vpc_id" {
    value = aws_vpc.app_vpc.id
  
}