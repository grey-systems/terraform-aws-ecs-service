# terraform-aws-ecs-service

This repo contains a [Terraform](https://terraform.io/) module to create an Amazon ECS Service in a ECS Cluster with HA support

* Creates the service
* Creates the task definition
* Creates the required AWS ALB to make the service available.

HA support is based on a multi-az vpc and also a multi-az cluster, both requirements can be fulfilled by using [terraform-aws-multitier-vpc](https://github.com/grey-systems/terraform-aws-multitier-vpc) and [terraform-aws-ecs-cluster](https://github.com/grey-systems/terraform-aws-ecs-cluster) modules.

Requirements
--------------
* existent VPC (https://github.com/grey-systems/terraform-aws-multitier-vpc)
* existent ECS Cluster (https://github.com/grey-systems/terraform-aws-ecs-cluster)


Module usage:

      provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region     = "us-east-1"
      }


Inputs
---------

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| cluster_id | The ID of the cluster in which this service will be created | - | yes |
| container_name | Container's name to pull | - | yes |
| container_port | The port in which the container is listening | `80` | no |
| container_protocol | The protocol in which the container is listening | `HTTP` | no |
| desired_count | ECS Service desired count | `1` | no |
| environment | used as prefix to name resources | - | yes |
| health_check_path | The destination for the health check request | `/` | no |
| internal | Determines if the ecs service ALB will be private or public | `true` | no |
| name | The name of the ecs service | - | yes |
| placement_strategy_field | ECS Service placement strategy field | `attribute:ecs.availability-zone` | no |
| placement_strategy_type | ECS Service placement strategy | `spread` | no |
| route53_zone_id | route53 zone id. If provided the module will create a dns record named ${name}.{route53_dns} for the ALB (CNAME record) | `` | no |
| service_allowed_cidr_blocks | CIDRs allowed to access the ALB. | `<list>` | no |
| service_iam_role_arn | Service IAM role ARN (must be already created). Check [terraform-ecs-cluster](https://github.com/grey-systems/terraform-ecs-cluster) module, that module creates a cluster and a service iam role following AWS recommendations to be used as ecs service iam role. | - | yes |
| service_port | The port in which the ALB will be listening | `80` | no |
| service_protocol | Protocol for ALB | `HTTP` | no |
| subnet_ids | List of VPC subnets to balance the ALBB | - | yes |
| task_definition | AWS ECS Task definition | - | yes |


Outputs
---------

| Name | Description |
|------|-------------|
| alb_dns_name | The DNS name of the application load balancer |


Contributing
------------
Everybody is welcome to contribute. Please, see [`CONTRIBUTING`][contrib] for further information.

[contrib]: CONTRIBUTING.md

Bug Reports
-----------

Bug reports can be sent directly to authors and/or using github's issues.


-------

Copyright (c) 2017 Grey Systems ([www.greysystems.eu](http://www.greysystems.eu))

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
