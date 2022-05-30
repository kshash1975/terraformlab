####### Declare variables ###############

variable "aws_access_key" {}
variable "aws_secret_key" {}



####### Define the provider 

provider "aws" {

	

}


####### Create the EC2 instance ###############

resource "aws_instance" "webserver" {
	
}

####### Output the Public DNS of the web server ###############

output "aws_public_dns" {

	
}