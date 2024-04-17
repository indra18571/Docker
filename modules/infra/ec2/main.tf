resource "aws_instance" "this" {
	ami = var.ami
	user_data = var.user-data
	instance_type = var.instance-type
        key_name = var.key-name
	tags = { Name = var.instance-name	}
	subnet_id = var.subnet-id
 	vpc_security_group_ids = [var.sg-id]
	  metadata_options {        http_tokens = "required"    }
	  iam_instance_profile = var.profile-name
	
}


