# --------------- VPC ---------------
resource "aws_vpc" "eggman" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name     = "eggman-vpc"
    Resource = "eggman"
  }
}

# --------------- Subnet ---------------
resource "aws_subnet" "eggman_pub1" {
  vpc_id = aws_vpc.eggman.id
  availability_zone = var.az["az1"]
  cidr_block = var.subnet_cidr_block["pub1"]
  map_public_ip_on_launch = true
  tags = {
    Name     = "eggman-subnet-pub1"
    Resource = "eggman"
  }
}

resource "aws_subnet" "eggman_pri1" {
  vpc_id = aws_vpc.eggman.id
  availability_zone = var.az["az1"]
  cidr_block = var.subnet_cidr_block["pri1"]
  map_public_ip_on_launch = true
  tags = {
    Name     = "eggman-subnet-pri1"
    Resource = "eggman"
  }
}

# --------------- Gateway ---------------
resource "aws_internet_gateway" "eggman_igw" {
  vpc_id = aws_vpc.eggman.id
  tags = {
    Name     = "eggman-igw"
    Resource = "eggman"
  }
}

resource "aws_eip" "eggman_ngw_eip" {
  vpc  = true
  tags = {
    Name     = "eggman-ngw-eip"
    Resource = "eggman"
  }
}

resource "aws_nat_gateway" "eggman_ngw" {
  allocation_id = aws_eip.eggman_ngw_eip.id
  subnet_id     = aws_subnet.eggman_pub1.id
  tags = {
    Name     = "eggman-ngw"
    Resource = "eggman"
  }
}

# --------------- Routing Table ---------------
resource "aws_route_table" "eggman_pub1" {
  vpc_id = aws_vpc.eggman.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eggman_igw.id
  }
  tags = {
    Name     = "eggman-routing-table-pub1"
    Resource = "eggman"
  }
}

resource "aws_route_table_association" "eggman_pub1" {
  subnet_id      = aws_subnet.eggman_pub1.id
  route_table_id = aws_route_table.eggman_pub1.id
}
