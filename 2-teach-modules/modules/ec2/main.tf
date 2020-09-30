# Enter the terraform resource block for an ec2 instance here.
# You will declare your variables when you call the module.

resource "aws_instance" "ec2-instance" {
 ami           = var.image_id
 instance_type = var.instance_type
 vpc_security_group_ids = [var.security_group]
 subnet_id = var.subnet
 key_name = var.key_name
 associate_public_ip_address = true

 tags = {
   Name = "${var.app_name}-${var.instance_name}-ec2Instance"
 }
}
