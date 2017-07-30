resource "aws_autoscaling_group" "asg" {
  name                 = "${var.name}"
  vpc_zone_identifier  = ["${var.instance_subnets}"]
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.lc.name}"
  load_balancers       = ["${aws_elb.elb.id}"]
  termination_policies = ["OldestInstance"]
  suspended_processes  = "${var.suspended_processes}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}_asg"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Group"
    value               = "${var.group}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Team"
    value               = "${var.team}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Project"
    value               = "${var.project}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Owner"
    value               = "${var.owner}"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Use"
    value               = "${var.use}"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "lc" {
  name_prefix          = "${var.name}_lc"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group_ids}"]
  user_data            = "${var.user_data}"
  iam_instance_profile = "${var.iam_instance_profile}"

  root_block_device {
    volume_type           = "${var.asg_root_volume_type}"
    volume_size           = "${var.asg_root_volume_size}"
    delete_on_termination = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "elb" {
  name = "${var.name}-elb"

  subnets         = ["${var.elb_subnets}"]
  security_groups = ["${var.security_group_ids}"]

  internal = "${var.internal}"

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "http"
  }
}

resource "aws_route53_record" "route53_record" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "CNAME"
  ttl     = "30"
  records = ["${aws_elb.elb.dns_name}"]
}
