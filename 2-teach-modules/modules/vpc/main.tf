# Virtual private cloud with custom cidr block.
resource "aws_vpc" "happy" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.app_name}-vpc"
  }
}

# Internet gateway attached to VPC.
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.happy.id

  tags = {
    Name = "${var.app_name}-ig"
  }
}

# Public subnet 1.
resource "aws_subnet" "public-1" {
  availability_zone = "${var.region}a"
  vpc_id = aws_vpc.happy.id
  cidr_block = var.public_subnet1_cidr_block

  tags = {
    Name = "${var.app_name}-publicsubnet-1"
  }
}

# Public subnet 2.
resource "aws_subnet" "public-2" {
  availability_zone = "${var.region}b"
  vpc_id = aws_vpc.happy.id
  cidr_block = var.public_subnet2_cidr_block

  tags = {
    Name = "${var.app_name}-publicsubnet-2"
  }
}

# Public route table.
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.happy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "${var.app_name}-public-rt"
  }
}

# Public route table association between public-subnet-1 and the public route table.
resource "aws_route_table_association" "rta-public-1" {
  subnet_id = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-rt.id
}

# Public route table association between public-subnet-2 and the public route table.
resource "aws_route_table_association" "rta-public-2" {
  subnet_id = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-rt.id
}

# Private subnet 1.
resource "aws_subnet" "private-1" {
  availability_zone = "${var.region}a"
  vpc_id = aws_vpc.happy.id
  cidr_block = var.private_subnet1_cidr_block

  tags = {
    Name = "${var.app_name}-privatesubnet-1"
  }
}

# Allocates an EIP to the nat gateway.
resource "aws_eip" "nat" {
  vpc = true
}

# Nat gateway set up in public-subnet-1.
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public-1.id
  tags = {
    Name = "${var.app_name}-nat-gateway"
  }
}

# Private route table which routes to the nat gateway in public-subnet-1.
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.happy.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "${var.app_name}-private-rt"
  }
}

# Associates the private subnets with the private route table.
resource "aws_route_table_association" "rta-private-1" {
  subnet_id = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-rt.id
}