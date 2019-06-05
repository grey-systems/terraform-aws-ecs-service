data "aws_subnet" "vpc" {
  id = "${element(var.subnet_ids,0)}"
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "${var.name}-${var.environment}"
  port     = "${var.container_port}"
  protocol = "${var.container_protocol}"
  vpc_id   = "${data.aws_subnet.vpc.vpc_id}"

  health_check {
    path = "${var.health_check_path}"
  }
}

resource "aws_alb" "alb" {
  name            = "${var.name}-${var.environment}"
  internal        = "${var.internal}"
  security_groups = ["${aws_security_group.alb_sec_group.id}"]
  subnets         = ["${var.subnet_ids}"]
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.service_port}"
  protocol          = "${var.service_protocol}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.name}-${var.environment}-family"
  container_definitions = "${var.task_definition}"
}

resource "aws_ecs_service" "ecs_service" {
  depends_on      = ["aws_alb_listener.alb_listener"]
  name            = "${var.name}-${var.environment}"
  cluster         = "${var.cluster_id}"
  task_definition = "${aws_ecs_task_definition.task_definition.arn}"
  iam_role        = "${var.service_iam_role_arn}"
  desired_count   = "${var.desired_count}"

   ordered_placement_strategy {

    type  = "${var.placement_strategy_type}"
    field = "${var.placement_strategy_field}"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }
}

resource "aws_route53_record" "service_dns" {
  name    = "${var.name}"
  records = ["${aws_alb.alb.dns_name}"]
  zone_id = "${var.route53_zone_id}"
  ttl     = "300"
  type    = "CNAME"
}

output "service_dns"
{
  value = "${aws_alb.alb.dns_name}"
}
