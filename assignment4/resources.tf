provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

data "aws_availability_zones" "available" {}


# NETWORKING #
resource "aws_vpc" "vpc" {
  
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  

}

resource "aws_subnet" "subnet" {
  
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.common_tags, { Name = "${local.env_name}-subnet${count.index + 1}" })

}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, { Name = "${local.env_name}-rtb" })
}

resource "aws_route_table_association" "rta-subnet" {
  
  route_table_id = aws_route_table.rtb.id
}



