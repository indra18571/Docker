variable "vpc-name" {}
variable "vpc-cidr" {}
variable "ig-name" {}
variable "public-sg-name" {}
variable "private-sg-name" {}
variable "public-rt-name" {}
variable "private-rt-name" {}
variable "default-nacl-name" {}
variable "private-nacl-name" {}
variable "anywhere-cidr" {}
variable "public-cidr" {}
variable "private-cidr" {}


variable "public-name" {}
variable "public-subnets" {
  type = map(object({
    name = string,
    cidr = string,
    az   = string
  }))
}

variable "instance-type" {}
variable "key-name" {}

variable "ec2-instance" {
  type = map(object({
    ami      = string
    name     = string
    filepath = string
  }))
}
variable "image" {}


