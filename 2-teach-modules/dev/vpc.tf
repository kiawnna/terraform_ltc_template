# This is where you call the vpc module.
module "vpc" {
  source               = "../modules/vpc"
  app_name             = var.app_name
  vpc_cidr_block       = "10.200.0.0/16"
  region               = var.region
  public_subnet1_cidr_block = "10.200.0.0/24"
  public_subnet2_cidr_block = "10.200.1.0/24"
}

module "security_group_public" {
  source              = "../modules/security_group"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  security_group_name = "public_security_group"
  ingress_rules = [
    {
      description = "All traffic on port 22"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
  }]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}

module "security_group_private" {
  source              = "../modules/security_group"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  security_group_name = "private_security_group"
  sg_ingress_rules = [
    {
      description = "All traffic from public instances security group"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = [module.security_group_public.security_group_id]
  }]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}
