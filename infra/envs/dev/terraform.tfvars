aws_region = "ap-south-1"


environment = "dev"


project_name = "devops-assessment"



vpc_cidr = "10.0.0.0/16"



availability_zones = [

  "ap-south-1a",

  "ap-south-1b"

]



public_subnet_cidrs = [

  "10.0.1.0/24",

  "10.0.2.0/24"

]



private_app_subnet_cidrs = [

  "10.0.11.0/24",

  "10.0.12.0/24"

]



private_db_subnet_cidrs = [

  "10.0.21.0/24",

  "10.0.22.0/24"

]



container_image = "nginx:latest"


container_port = 80



db_name = "appdb"


db_username = "admin"


db_password = "ChangeMe123!"
