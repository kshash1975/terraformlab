####### Declare variables ###############

variable "aws_access_key" {}
variable "aws_secret_key" {}



####### Define the provider 

provider "aws" {

	

}

####### Look up AMI ###############

data "aws_ami" "aws-linux" {
  most_recent = true
  owners = ["amazon"]
 
}

####### Select the VPC ###############

resource "aws_default_vpc" "default" {}

####### Create and configure security group ###############

resource "aws_security_group" "allow_webtraffic" {
	name = "webserver_demo"
	description = "Web server security group for demo"
	
}

####### Create the EC2 instance ###############

resource "aws_instance" "webserver" {
	
}

####### Output the Public DNS of the web server ###############

output "aws_public_ip" {
	
}