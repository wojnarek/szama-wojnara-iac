resource "aws_vpc" "app_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-${count.index}"
  }

}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "IGW"
  }

}

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.vpc_name}-public_rt"
  }

}


resource "aws_route" "rt_public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = var.destination_for_public_route
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_assoc_public" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.vpc_name}-private_rt"
  }

}

resource "aws_route_table_association" "name" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id

}