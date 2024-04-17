
resource "aws_vpc" "this" {
  cidr_block = var.vpc-cidr
enable_dns_hostnames = true
  tags = {	    Name = var.vpc-name	  }
}

resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id
	route {
    cidr_block = var.vpc-cidr
    gateway_id = "local"	 
     }
      route {
    cidr_block = var.anywhere-cidr
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {	    Name =  var.public-rt-name	  }
}

resource "aws_route_table" "this" {
	vpc_id = aws_vpc.this.id
	route {
    cidr_block = var.vpc-cidr
    gateway_id = "local"	 
     }
        tags = {	    Name =  var.private-rt-name	  }
}

resource "aws_default_security_group" "this" {
	vpc_id = aws_vpc.this.id
	 tags = {	    Name =  var.public-sg-name		  }
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anywhere-cidr]
  }
ingress {
    cidr_blocks = [ var.anywhere-cidr   ]
	from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = [ var.anywhere-cidr   ]
	from_port = 3389
    to_port = 3389
    protocol = "tcp"
  }
    ingress {
    cidr_blocks = [ var.anywhere-cidr   ]
	from_port = 443
    to_port = 443
    protocol = "tcp"
  }
}

resource "aws_security_group" "this" {
	vpc_id = aws_vpc.this.id
	 tags = {	    Name =  var.private-sg-name		  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anywhere-cidr]
  }
ingress {
    cidr_blocks = [       var.public-cidr	    ]
	from_port = 22
    to_port = 22
    protocol = "tcp"
  }

}

resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 0
    to_port    = 0
  }
 	 tags = {
    Name =  var.default-nacl-name
	  }
   lifecycle {	    ignore_changes = [subnet_ids]	  }
}

resource "aws_network_acl" "this" {
	vpc_id =  aws_vpc.this.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.anywhere-cidr
    from_port  = 0
    to_port    = 0
  }
 	 tags = {
    Name =  var.private-nacl-name
	  }
   lifecycle {	    ignore_changes = [subnet_ids]	  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = var.ig-name
  }
}
