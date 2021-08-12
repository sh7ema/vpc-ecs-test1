// network.tf

// Look AZs in current region
data "aws_availability_zones" "avialable" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.app_name}-${var.env}"
  }
}

// Create private subnet in two AZs
resource "aws_subnet" "private" {
  count = var.az_count
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidr, count.index)
  availability_zone = data.aws_availability_zones.avialable.names[count.index]
  tags = {
    Name = "${var.app_name}-${var.env}-private"
  }
}

//Create public subnet in two AZs
resource "aws_subnet" "public" {
  count = var.az_count
  cidr_block = element(var.public_subnet_cidr, count.index)
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.avialable.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.app_name}-${var.env}-public"
  }
}

// Internet Gateway for public subnet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.app_name}-${var.env}-ig"
  }
}

// Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

// Create NAT gateway with Elastic IP for each private subnet to get internet connect
resource "aws_eip" "gw" {
  count = var.az_count
  vpc = true
  depends_on = [aws_internet_gateway.main]
  tags = {
    Name = "${var.app_name}-${var.env}-EIP"
  }
}

resource "aws_nat_gateway" "gw" {
  count = var.az_count
  subnet_id = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)
  tags = {
    Name = "${var.app_name}-${var.env}-GW"
  }
}

// Create a new route table for the private subnets across NAT
resource "aws_route_table" "private" {
  count = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }
  tags {
    Name = "${var.app_name}-${var.env}-RT"
  }
}

// Explicitly associate the newly created route tables to the private subnets
resource "aws_route_table_association" "private" {
  count = var.az_count
  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
