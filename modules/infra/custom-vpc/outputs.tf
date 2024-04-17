
output "vpc-id" { value = aws_vpc.this.id }
output "public-rt-id" { value = aws_default_route_table.this.id}
output "private-rt-id" {value = aws_route_table.this.id}
output "public-nacl-id" { value = aws_default_network_acl.this.id }
output "private-nacl-id" { value = aws_network_acl.this.id  }
output "public-sg-id"   { value = aws_default_security_group.this.id }
output "private-sg-id" { value = aws_security_group.this.id }
output "ig-id" { value = aws_internet_gateway.this.id   }

