// The name of the ecs service
variable "name" {
  type = "string"
}

// Determines if the ecs service ALB will be private or public
variable "internal" {
  type    = "string"
  default = "true"
}

// List of VPC subnets to balance the ALBB
variable "subnet_ids" {
  type = "list"
}

// The port in which the ALB will be listening
variable "service_port" {
  type    = "string"
  default = "80"
}

// Protocol for ALB
variable "service_protocol" {
  type    = "string"
  default = "HTTP"
}

// The port in which the container is listening
variable "container_port" {
  type    = "string"
  default = "80"
}

// The protocol in which the container is listening
variable "container_protocol" {
  type    = "string"
  default = "HTTP"
}

// AWS ECS Task definition
variable "task_definition" {
  type = "string"
}

// Container's name to pull
variable "container_name" {
  type = "string"
}

// Service IAM role ARN (must be already created). Check [terraform-ecs-cluster](https://github.com/grey-systems/terraform-ecs-cluster) module, that module creates a cluster and a service iam role following AWS recommendations to be used as ecs service iam role.
variable "service_iam_role_arn" {
  type = "string"
}

// The ID of the cluster in which this service will be created
variable "cluster_id" {
  type = "string"
}

// used as prefix to name resources
variable "environment" {
  type = "string"
}

// ECS Service placement strategy
variable "placement_strategy_type" {
  type    = "string"
  default = "spread"
}

// ECS Service placement strategy field
variable "placement_strategy_field" {
  type    = "string"
  default = "attribute:ecs.availability-zone"
}

// route53 zone id. If provided the module will create a dns record named ${name}.{route53_dns}
// for the ALB (CNAME record)
variable "route53_zone_id" {
  type    = "string"
  default = ""
}

// ECS Service desired count
variable "desired_count" {
  type    = "string"
  default = "1"
}

// CIDRs allowed to access the ALB.
variable "service_allowed_cidr_blocks" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

// The destination for the health check request
variable "health_check_path" {
  type    = "string"
  default = "/"
}

// The DNS name of the application load balancer
output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
