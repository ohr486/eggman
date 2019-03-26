resource "aws_vpc" "eggman" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags {
    Name     = "eggman-vpc"
    Resource = "eggman"
  }
}

resource "aws_subnet" "eggman1" {
  vpc_id = "${aws_vpc.eggman.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.30.0.0/20"
  map_public_ip_on_launch = true
  tags {
    Name     = "eggman-subnet1"
    Resource = "eggman"
  }
}

resource "aws_subnet" "eggman2" {
  vpc_id = "${aws_vpc.eggman.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.30.16.0/20"
  map_public_ip_on_launch = true
  tags {
    Name     = "eggman-subnet2"
    Resource = "eggman"
  }
}

resource "aws_internet_gateway" "eggman" {
  vpc_id = "${aws_vpc.eggman.id}"
  tags {
    Name     = "eggman-igw"
    Resource = "eggman"
  }
}

resource "aws_route_table" "eggman" {
  vpc_id = "${aws_vpc.eggman.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eggman.id}"
  }
  lifecycle {
    ignore_changes = ["route"]
  }
  tags {
    Name     = "eggman-routing-table"
    Resource = "eggman"
  }
}

resource "aws_route_table_association" "eggman1" {
  subnet_id      = "${aws_subnet.eggman1.id}"
  route_table_id = "${aws_route_table.eggman.id}"
}
