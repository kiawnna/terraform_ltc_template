resource "aws_instance" "learnTheCloudTest" {
  ami = var.image_id
  instance_type = var.instance_type
  key_name = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.app_name}-instance"
  }
}