# This is where you call the ec2 module.
module "ec2-pub1" {
 source              = "../modules/ec2"
 app_name            = var.app_name
 instance_name = "my-public-ec2-instance"
 instance_type = "t2.micro"
 key_name = "kia-us-east-1"
 image_id = "ami-0b22c910bce7178b6"
 security_group = module.security_group_public.security_group_id
 subnet = module.vpc.subnet_id1
}

module "ec2-pub2" {
 source              = "../modules/ec2"
 app_name            = var.app_name
 instance_name = "my-public-ec2-instance-2"
 instance_type = "t2.micro"
 key_name = "kia-us-east-1"
 image_id = "ami-0b22c910bce7178b6"
 security_group = module.security_group_public.security_group_id
 subnet = module.vpc.subnet_id2
}

module "ec2-private1" {
 source              = "../modules/ec2"
 app_name            = var.app_name
 instance_name = "my-private-ec2-instance"
 instance_type = "t2.micro"
 key_name = "kia-us-east-1"
 image_id = "ami-0b22c910bce7178b6"
 security_group = module.security_group_private.security_group_id
 subnet = module.vpc.private_subnet_id1
}