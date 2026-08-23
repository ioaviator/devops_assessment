
output "public_subnet" {
  value = aws_subnet.public.id
}

output "security_group" {
  value = aws_security_group.ecs_sg.id
}