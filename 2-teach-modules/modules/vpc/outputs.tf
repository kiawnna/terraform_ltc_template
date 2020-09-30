output "vpc_id" {
  value = aws_vpc.happy.id
}
output "subnet_id1" {
  value = aws_subnet.public-1.id
}
output "subnet_id2" {
  value = aws_subnet.public-2.id
}
output "private_subnet_id1" {
  value = aws_subnet.private-1.id
}
