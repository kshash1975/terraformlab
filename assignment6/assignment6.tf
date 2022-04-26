####### Declare variables ###############

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
	default = "us-east-1"
}

variable "network_address_space" {
	default = "10.0.0.0/16"
}

variable "mysubnet_address_space" {
	default = "10.0.1.0/24"
}

####### Define the provider 

provider "aws" {

	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region = var.aws_region

}

######## Data look up - Availability Zone #####

data "aws_availability_zones" "available" {}

####### Look up AMI ###############

data "aws_ami" "aws-linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
	name = "name"
	values = ["amzn2-ami-hvm*"]
  }
  filter {
	name = "root-device-type"
	values = ["ebs"]
  }
  filter {
	name = "virtualization-type"
	values = ["hvm"]
  }
}


####### CREATE a NEW VPC ###############

resource "aws_vpc" "vpc" {
	cidr_block = var.network_address_space
	enable_dns_hostnames = "true"
}

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "mysubnet" {
	cidr_block = var.mysubnet_address_space
	vpc_id = aws_vpc.vpc.id
	map_public_ip_on_launch = "true"
	availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_route_table" "rtb" {
	vpc_id = aws_vpc.vpc.id
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}
}

resource "aws_route_table_association" "rta-mysubnet" {
	subnet_id = aws_subnet.mysubnet.id
	route_table_id = aws_route_table.rtb.id
}

####### Security group ###############

resource "aws_security_group" "allow_webtraffic" {
	name = "webserver_demo"
	description = "Web server security group for demo"
	vpc_id = aws_vpc.vpc.id 
	
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = -1
		cidr_blocks = ["0.0.0.0/0"]
	}
}

## Invoke the EC2 module to create the EC2 instance ##


## Output the Public DNS of the EC2 ##





