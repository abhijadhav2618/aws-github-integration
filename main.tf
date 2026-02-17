resource "aws_vpc" "vpc" {
    cidr_block = "192.168.0.0/16"
    instance_tenancy = "dedicated"
    tags = {
        Name = "Dev-VPC"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.1.0/24"
    tags = {
        Name = "Public-Subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "192.168.2.0/24"
    tags = {
        Name = "Private Subnet"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Internet-Gateway"
    }
}

resource "aws_route_table" "public-RT" {
    vpc_id = aws_vpc.vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        Name = "Public-RT"
    }
}

resource "aws_route_table_association" "public-rt-association" {
    route_table_id = aws_route_table.public-RT.id
    subnet_id = aws_subnet.public_subnet.id
}



