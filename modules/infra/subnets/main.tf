resource "aws_subnet" "this" {
	  vpc_id            = var.vpc-id
  tags = {Name = var.subnet-name }
  cidr_block        = var.subnet-cidr
  availability_zone = var.subnet-az
  map_public_ip_on_launch = var.public-ip-req	
  }
  
 resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = var.rt-id
}

resource "aws_network_acl_association" "main" {
  network_acl_id = var.nacl-id
  subnet_id      = aws_subnet.this.id
}


