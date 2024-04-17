
module "vpc" {
  source            = "./modules/infra/custom-vpc"
  vpc-name          = var.vpc-name
  vpc-cidr          = var.vpc-cidr
  ig-name           = var.ig-name
  public-sg-name    = var.public-sg-name
  private-sg-name   = var.private-sg-name
  public-cidr       = var.public-cidr
  private-cidr      = var.private-cidr
  public-rt-name    = var.public-rt-name
  private-rt-name   = var.private-rt-name
  default-nacl-name = var.default-nacl-name
  private-nacl-name = var.private-nacl-name
  anywhere-cidr     = var.anywhere-cidr
}

module "public-subnets" {
  depends_on    = [module.vpc]
  for_each      = var.public-subnets
  source        = "./modules/infra/subnets"
  vpc-id        = module.vpc.vpc-id
  subnet-name   = each.value["name"]
  subnet-cidr   = each.value["cidr"]
  subnet-az     = each.value["az"]
  public-ip-req = true
  rt-id         = module.vpc.public-rt-id
  nacl-id       = module.vpc.public-nacl-id
}




module "input-ec2" {
  source   = "./modules/infra/pre-ec2"
  key-name = var.key-name
}

module "iam-profile" {
  source = "./modules/infra/iam-prof"
}

module "instances" {
  depends_on    = [module.public-subnets, module.input-ec2]
  for_each      = module.public-subnets
  source        = "./modules/infra/ec2"
  subnet-id     = each.value["subnet-id"]
  ami           = var.ec2-instance[var.image].ami
  user-data     = file(var.ec2-instance[var.image].filepath)
  instance-name = "${each.value["subnet-name"]}-${var.image}"
  instance-type = var.instance-type
  key-name      = var.key-name
  sg-id         = module.vpc.public-sg-id
  profile-name  = module.iam-profile.iam-instance-profile-name
}



//https://medium.com/appgambit/part-1-running-docker-on-aws-ec2-cbcf0ec7c3f8






