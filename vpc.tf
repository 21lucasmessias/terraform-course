resource "aws_vpc" "fc-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
	tags = {
		Name = "${var.prefix}-vpc"
	}
}

data "aws_availability_zones" "available" {
	state = "available"
}

resource "aws_subnet" "fc-subnets" {
	count = 2
	availability_zone = data.aws_availability_zones.available.names[count.index]
	vpc_id = aws_vpc.fc-vpc.id
	cidr_block = "10.0.${count.index}.0/24"
	map_public_ip_on_launch = true
	tags = {
		Name = "${var.prefix}-subnet-${count.index + 1}"
	}
}

resource "aws_internet_gateway" "fc-igw" {
  vpc_id = aws_vpc.fc-vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "fc-rtb" {
	vpc_id = aws_vpc.fc-vpc.id

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.fc-igw.id
	}

	tags = {
		Name = "${var.prefix}-rtb"
	}
}

resource "aws_route_table_association" "fc-rtb-assoc" {
	count = 2
	subnet_id = aws_subnet.fc-subnets[count.index].id
	route_table_id = aws_route_table.fc-rtb.id
}