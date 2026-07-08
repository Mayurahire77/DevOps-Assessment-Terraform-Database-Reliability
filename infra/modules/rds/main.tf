#Part 1

############################################
# RDS Security Group
############################################

resource "aws_security_group" "rds" {

  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security Group for PostgreSQL RDS"
  vpc_id      = var.vpc_id

  ingress {

    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = var.allowed_security_groups
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-rds-sg"
    }
  )
}

############################################
# DB Subnet Group
############################################

resource "aws_db_subnet_group" "this" {

  name = "${var.project_name}-${var.environment}-db-subnet-group"

  subnet_ids = var.private_db_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-db-subnet-group"
    }
  )
}

############################################
# DB Parameter Group
############################################

resource "aws_db_parameter_group" "this" {

  name = "${var.project_name}-${var.environment}-postgres-params"

  family = var.family

  description = "PostgreSQL Parameter Group"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }

  parameter {
    name  = "log_statement"
    value = "ddl"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-parameter-group"
    }
  )
}

############################################
# IAM Role for Enhanced Monitoring
############################################

data "aws_iam_policy_document" "rds_monitoring_assume_role" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "monitoring.rds.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "rds_monitoring" {

  name = "${var.project_name}-${var.environment}-rds-monitoring-role"

  assume_role_policy = data.aws_iam_policy_document.rds_monitoring_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {

  role = aws_iam_role.rds_monitoring.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

#Part 2

############################################
# PostgreSQL RDS Instance
############################################

resource "aws_db_instance" "this" {

  identifier = "${var.project_name}-${var.environment}-postgres"

  engine         = var.engine
  engine_version = var.engine_version

  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  storage_encrypted = var.storage_encrypted

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 5432

  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  publicly_accessible = var.publicly_accessible
  multi_az            = var.multi_az

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  maintenance_window = var.maintenance_window

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  performance_insights_enabled = var.performance_insights_enabled

  enabled_cloudwatch_logs_exports = [
    "postgresql",
    "upgrade"
  ]

  auto_minor_version_upgrade = true
  apply_immediately          = true

  deletion_protection = var.deletion_protection

  skip_final_snapshot = var.skip_final_snapshot

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-${var.environment}-final-snapshot"

  copy_tags_to_snapshot = true

  #publicly_accessible = false

  delete_automated_backups = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-postgres"
    }
  )

  depends_on = [
    aws_db_parameter_group.this,
    aws_db_subnet_group.this,
    aws_iam_role_policy_attachment.rds_monitoring
  ]
}