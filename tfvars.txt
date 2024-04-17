vpc-name          = "infra"
vpc-cidr          = "10.0.0.0/20"
ig-name           = "infra"
public-sg-name    = "ifra-public"
private-sg-name   = "infra-private"
public-rt-name    = "infra-public"
private-rt-name   = "infra-private"
default-nacl-name = "infra-public"
private-nacl-name = "infra-private"
anywhere-cidr     = "0.0.0.0/0"
public-cidr       = "10.0.0.0/24"
private-cidr      = "10.0.1.0/24"


public-name = "infra-public"
public-subnets = {
  subnet1 = {
    name = "infra-public1"
    cidr = "10.0.2.0/24"
    az   = "eu-west-2a"
  }
  /*
  ,
  subnet2 = {
    name = "infra-public2"
    cidr = "10.0.3.0/24"
    az   = "eu-west-2b"
  }
  */
}


instance-type = "t2.micro"
key-name      = "infra-keypair1"


ec2-instance = {
  Windows = {
    ami      = "ami-0f00a31129b3158a1"
    name     = "infra-windows"
    filepath = "./modules/infra/ec2/data-windows.sh"
  }
  Redhat = {
    ami      = "ami-035cecbff25e0d91e"
    name     = "infra-Redhat"
    filepath = "./modules/infra/ec2/data-Redhat.sh"
  }
  Ubuntu = {
    ami      = "ami-0b9932f4918a00c4f"
    name     = "infra-Ubuntu"
    filepath = "./modules/infra/ec2/data-Ubuntu.sh"
  }
  Amazon = {
    ami      = "ami-0c618421e207909d0"
    name     = "infra-Amazon"
    filepath = "./modules/infra/ec2/data-Amazon.sh"
  }
}
image = "Redhat"


