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

resource "aws_subnet" "subnets" {
	count = 2
	availability_zone = data.aws_availability_zones.available.names[count.index]
	vpc_id = aws_vpc.fc-vpc.id
	cidr_block = "10.0.${count.index}.0/24"
	map_public_ip_on_launch = true
	tags = {
		Name = "${var.prefix}-subnet-${count.index + 1}"
	}
}