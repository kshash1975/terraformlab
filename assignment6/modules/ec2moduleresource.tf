variable ami {type=string}
variable instance_type {type=string}
variable subnet_id  {type=string}
variable vpc_security_group_ids {type = list}
variable user_data {type = string}


####### Create the EC2 instance ###############

resource "aws_instance" "webserver" {
	
}

####### Output the Public DNS of the web server ###############

output "aws_public_ip" {
	
}