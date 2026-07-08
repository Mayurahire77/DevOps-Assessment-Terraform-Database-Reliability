#Part 1 

############################################
# CloudWatch Log Group
############################################

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = var.log_retention_days

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-logs"
    }
  )
}

############################################
# ECS Cluster
############################################

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(
    var.tags,
    {
      Name = var.cluster_name
    }
  )
}

############################################
# ECS Task Execution Role
############################################

data "aws_iam_policy_document" "ecs_task_execution_assume_role" {

  statement {

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "ecs_execution_role" {

  name = "${var.project_name}-${var.environment}-ecs-execution-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {

  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

############################################
# ECS Task Role
############################################

resource "aws_iam_role" "ecs_task_role" {

  name = "${var.project_name}-${var.environment}-ecs-task-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json

  tags = var.tags
}

############################################
# Application Load Balancer Security Group
############################################

resource "aws_security_group" "alb" {

  name = "${var.project_name}-${var.environment}-alb-sg"

  description = "ALB Security Group"

  vpc_id = var.vpc_id

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-alb-sg"
    }
  )
}

############################################
# ECS Service Security Group
############################################

resource "aws_security_group" "ecs" {

  name = "${var.project_name}-${var.environment}-ecs-sg"

  description = "ECS Service Security Group"

  vpc_id = var.vpc_id

  ingress {

    from_port = var.container_port

    to_port = var.container_port

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-sg"
    }
  )
}

#Part 2

############################################
# Application Load Balancer
############################################

resource "aws_lb" "this" {

  name = "${var.project_name}-${var.environment}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-alb"
    }
  )
}

############################################
# Target Group
############################################

resource "aws_lb_target_group" "this" {

  name = "${var.project_name}-${var.environment}-tg"

  port = var.container_port

  protocol = "HTTP"

  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {

    enabled = true

    path = var.health_check_path

    protocol = "HTTP"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 3
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-tg"
    }
  )
}

############################################
# ALB Listener
############################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port = var.listener_port

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}

############################################
# ECS Task Definition
############################################

resource "aws_ecs_task_definition" "this" {

  family = "${var.project_name}-${var.environment}"

  network_mode = "awsvpc"

  requires_compatibilities = [
    "FARGATE"
  ]

  cpu = var.cpu

  memory = var.memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  task_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name = var.container_name

      image = var.container_image

      essential = true

      portMappings = [
        {
          containerPort = var.container_port

          hostPort = var.container_port

          protocol = "tcp"
        }
      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs.name

          awslogs-region = data.aws_region.current.name

          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  runtime_platform {

    operating_system_family = "LINUX"

    cpu_architecture = "X86_64"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-task"
    }
  )
}

############################################
# Current AWS Region
############################################

data "aws_region" "current" {}

#Part 3

############################################
# ECS Service
############################################

resource "aws_ecs_service" "this" {

  name            = "${var.project_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count

  launch_type = "FARGATE"

  enable_execute_command = true

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {

    subnets = var.private_subnet_ids

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.this.arn

    container_name = var.container_name

    container_port = var.container_port
  }

  depends_on = [
    aws_lb_listener.http
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-service"
    }
  )
}

############################################
# Auto Scaling Target
############################################

resource "aws_appautoscaling_target" "ecs" {

  count = var.enable_autoscaling ? 1 : 0

  max_capacity = var.max_capacity

  min_capacity = var.min_capacity

  resource_id = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"

  scalable_dimension = "ecs:service:DesiredCount"

  service_namespace = "ecs"
}

############################################
# CPU Auto Scaling Policy
############################################

resource "aws_appautoscaling_policy" "cpu" {

  count = var.enable_autoscaling ? 1 : 0

  name = "${var.project_name}-${var.environment}-cpu-policy"

  policy_type = "TargetTrackingScaling"

  resource_id = aws_appautoscaling_target.ecs[0].resource_id

  scalable_dimension = aws_appautoscaling_target.ecs[0].scalable_dimension

  service_namespace = aws_appautoscaling_target.ecs[0].service_namespace

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 70

    scale_in_cooldown = 120

    scale_out_cooldown = 60
  }
}
