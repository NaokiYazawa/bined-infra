resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.ecs_service_desired_count
  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.security_group_ecs_id]
  }
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.family
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
  task_role_arn            = module.ecs_task_execution_role.iam_role_arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  container_definitions    = templatefile("${path.module}/task_definitions.json")
  # NOTE: Dummy container for initial.
#   container_definitions = <<CONTAINERS
# [
#   {
#     "name": "${var.container_name}",
#     "image": "medpeer/health_check:latest",
#     "portMappings": [
#       {
#         "hostPort": ${var.container_port},
#         "containerPort": ${var.container_port}
#       }
#     ],
#     "logConfiguration": {
#       "logDriver": "awslogs",
#       "options": {
#         "awslogs-group": "${aws_cloudwatch_log_group.cloudwatch_log_group.name}",
#         "awslogs-region": "ap-northeast-1",
#         "awslogs-stream-prefix": "app"
#       }
#     },
#     "environment": [
#       {
#         "name": "NGINX_PORT",
#         "value": "${var.container_port}"
#       },
#       {
#         "name": "HEALTH_CHECK_PATH",
#         "value": "/healthz"
#       }
#     ]
#   }
# ]
# CONTAINERS
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = 1
}

# ================
# ECS Task IAM
# ================
data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_policy_documents = [data.aws_iam_policy.ecs_task_execution_role_policy.policy]
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::110728338021:role/ecsTaskExecutionRole"]
  }
  statement {
    effect    = "Allow"
    actions   = ["ecs:ExecuteCommand"]
    resources = ["arn:aws:iam::110728338021:role/ecsTaskExecutionRole"]
  }
}

module "ecs_task_execution_role" {
  source     = "./../iam_role/"
  name       = var.ecs_task_execution_role_name
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}
