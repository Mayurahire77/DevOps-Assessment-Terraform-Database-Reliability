terraform {

  backend "s3" {

    bucket = "your-prod-terraform-state-bucket"

    key = "prod/terraform.tfstate"

    region = "ap-south-1"


    dynamodb_table = "terraform-locks"


    encrypt = true

  }

}