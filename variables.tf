variable "name" {}

variable "asg_max" {
  default = "1"
}

variable "asg_min" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}

variable "availability_zones" {}

variable "subnets" {
  default = []
}

variable "aws_amis" {
  default = {
    eu-west-1 = "ami-02ace471"
  }
}

variable "aws_region" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair_id" {}
