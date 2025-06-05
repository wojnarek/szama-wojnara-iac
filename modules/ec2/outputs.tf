output "frontend_vm_id_for_alb" {
  value = aws_instance.vm_frontend.id

}
output "backend_vm_id_for_alb" {
  value = aws_instance.vm_backend.id

}

output "backend_sg_ids" {
value = aws_security_group.sg_backend.id 
}