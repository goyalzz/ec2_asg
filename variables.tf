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

variable "subnets" {
  default = []
}

variable "aws_ami_map" {
  type = "map"

  default = {
    ap-south-1-centos     = "ami-95cda6fa"
    ap-south-1-ubuntu     = "ami-dd3442b2"
    ap-southeast-1-centos = "ami-f068a193"
    eu-west-1-centos      = "ami-7abd0209"
  }
}

variable "aws_region_os" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair_id" {}

variable "availability_zones" {
  default = ""
}

variable "subnets" {
  default = ""
}
