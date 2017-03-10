resource "aws_autoscaling_group" "asg" {
  name                 = "${var.name}"
  vpc_zone_identifier  = ["${var.instance_subnets}"]
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.lc.name}"
  load_balancers       = "${aws_elb.elb.id}"
  termination_policies = "OldestInstance"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}_asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "lc" {
  name_prefix     = "${var.name}_lc"
  image_id        = "${var.ami_id}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${var.security_group_ids}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "elb" {
  name = "${var.name}-elb"

  subnets         = ["${var.elb_subnets}"]
  security_groups = ["${var.security_group_ids}"]

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "http"
  }
}
