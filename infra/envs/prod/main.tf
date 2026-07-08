############################################
# Network Module
############################################

module "network" {

  source = "../../modules/network"


  project_name = var.project_name

  environment = var.environment


  vpc_cidr = var.vpc_cidr


  availability_zones = var.availability_zones


  public_subnet_cidrs = var.public_subnet_cidrs


  private_app_subnet_cidrs = var.private_app_subnet_cidrs


  private_db_subnet_cidrs = var.private_db_subnet_cidrs


  # Production NAT Gateway

  enable_nat_gateway = true

  single_nat_gateway = false



  tags = {

    Environment = var.environment

    Project = var.project_name

  }

}



############################################
# ECS Module
############################################

module "ecs" {

  source = "../../modules/ecs"



  project_name = var.project_name

  environment = var.environment



  vpc_id = module.network.vpc_id



  public_subnet_ids = module.network.public_subnet_ids



  private_subnet_ids = module.network.private_app_subnet_ids



  cluster_name = "${var.project_name}-${var.environment}-cluster"



  container_name = "app"



  container_image = var.container_image



  container_port = var.container_port



  # Production Capacity

  cpu = 512


  memory = 1024



  desired_count = 3



  health_check_path = "/"



  # Enable Auto Scaling

  enable_autoscaling = true



  min_capacity = 3


  max_capacity = 10



  tags = {

    Environment = var.environment

    Project = var.project_name

  }

}



############################################
# RDS Module
############################################

module "rds" {

  source = "../../modules/rds"



  project_name = var.project_name

  environment = var.environment



  vpc_id = module.network.vpc_id



  private_db_subnet_ids = module.network.private_db_subnet_ids



  allowed_security_groups = [

    module.ecs.ecs_security_group_id

  ]



  db_name = var.db_name



  db_username = var.db_username



  db_password = var.db_password



  engine = "postgres"



  engine_version = "16.3"



  # Production Database Size

  instance_class = "db.t3.medium"



  allocated_storage = 100



  max_allocated_storage = 500



  storage_type = "gp3"



  # High Availability

  multi_az = true



  publicly_accessible = false



  # Backup

  backup_retention_period = 30



  backup_window = "02:00-03:00"



  maintenance_window = "Sun:04:00-Sun:05:00"



  # Monitoring

  performance_insights_enabled = true



  monitoring_interval = 60



  # Security

  storage_encrypted = true



  deletion_protection = true



  skip_final_snapshot = false



  tags = {

    Environment = var.environment

    Project = var.project_name

  }

}