
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


  enable_nat_gateway = true

  single_nat_gateway = true


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



  cpu = 256


  memory = 512



  desired_count = 2



  health_check_path = "/"



  enable_autoscaling = false



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



  instance_class = "db.t3.micro"



  allocated_storage = 20



  multi_az = false



  publicly_accessible = false



  backup_retention_period = 7



  deletion_protection = false



  skip_final_snapshot = true



  tags = {

    Environment = var.environment

    Project = var.project_name

  }

}