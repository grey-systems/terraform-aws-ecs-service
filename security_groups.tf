resource "aws_security_group" "alb_sec_group" {
  name        = "${var.name}-${var.environment}-secgroup"
  description = "Security group for alb ${var.name}"
  vpc_id      = "${data.aws_subnet.vpc.vpc_id}"

  ingress {
    from_port   = "${var.service_port}"
    to_port     = "${var.service_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.service_allowed_cidr_blocks}"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    name = "${var.name}-${var.environment}-secgroup"
    Env  = "${var.environment}"
  }
}
