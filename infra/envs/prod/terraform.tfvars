aws_region = "ap-south-1"


environment = "prod"


project_name = "devops-assessment"



vpc_cidr = "10.10.0.0/16"



availability_zones = [

  "ap-south-1a",

  "ap-south-1b"

]



public_subnet_cidrs = [

  "10.10.1.0/24",

  "10.10.2.0/24"

]



private_app_subnet_cidrs = [

  "10.10.11.0/24",

  "10.10.12.0/24"

]



private_db_subnet_cidrs = [

  "10.10.21.0/24",

  "10.10.22.0/24"

]



container_image = "nginx:latest"


container_port = 80



db_name = "productiondb"


db_username = "admin"


db_password = "ChangeMe123!"
