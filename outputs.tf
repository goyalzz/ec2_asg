output "dns" {
  value = "${aws_elb.elb.dns_name}"
}
