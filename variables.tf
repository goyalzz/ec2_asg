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

variable "elb_subnets" {
  default = []
}

variable "instance_subnets" {
  default = []
}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = ""
}

variable "availability_zones" {
  default = ""
}

variable "security_group_ids" {
  type = "list"
}

variable "instance_port" {
  default = "80"
}

variable "lb_port" {
  default = "80"
}

variable "user_data" {
  default = ""
}
