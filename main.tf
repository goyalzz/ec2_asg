resource "aws_autoscaling_group" "asg" {
  name                 = "${var.name}"
  vpc_zone_identifier  = ["${var.subnets}"]
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.lc.name}"

  tag {
    key                 = "Name"
    value               = "${var.name}_asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "lc" {
  name          = "${var.name}_lc"
  image_id      = "${lookup(var.aws_ami_map, var.aws_region_os)}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_pair_id}"
}

resource "aws_elb" "elb" {
  name               = "${var.name}-elb"
  availability_zones = ["${split(",", var.availability_zones)}"]
  subnets            = ["${split(",", var.subnets)}"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
