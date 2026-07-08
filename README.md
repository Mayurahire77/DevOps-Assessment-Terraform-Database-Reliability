# AWS DevOps Assessment

## Project Overview

This project demonstrates a production-ready AWS infrastructure built using **Terraform Infrastructure as Code (IaC)**. The infrastructure is modular, reusable, and supports both **Development** and **Production** environments.

### Technologies Used

* AWS
* Terraform
* Amazon VPC
* Amazon ECS Fargate
* Amazon RDS PostgreSQL
* Application Load Balancer
* CloudWatch
* IAM
* GitHub Actions
* Docker
* PostgreSQL

---

# Architecture

```text
                    Internet
                        |
                        |
             Application Load Balancer
                        |
                        |
                 ECS Fargate Service
                        |
            -------------------------
            |                       |
      Private App Subnets      CloudWatch Logs
            |
            |
      PostgreSQL RDS
      Private DB Subnets
            |
      Automated Backups

      GitHub Actions
             |
        Terraform
             |
       AWS Infrastructure
```

---

# Repository Structure

```text
devops-assessment/
│
├── infra/
│   ├── modules/
│   │   ├── network/
│   │   ├── ecs/
│   │   └── rds/
│   │
│   └── envs/
│       ├── dev/
│       └── prod/
│
├── database/
│   ├── docker-compose.yml
│   ├── migrations/
│   └── seeds/
│
├── scripts/
│   ├── backup.sh
│   └── restore.sh
│
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── README.md
└── .gitignore
```

---

# Infrastructure Components

## Network

* Amazon VPC
* Public Subnets
* Private Application Subnets
* Private Database Subnets
* Internet Gateway
* NAT Gateway
* Route Tables

## Compute

* Amazon ECS Cluster
* ECS Fargate
* Task Definition
* ECS Service

## Load Balancer

* Application Load Balancer
* Target Group
* Listener

## Database

* Amazon RDS PostgreSQL
* DB Subnet Group
* Parameter Group
* Automated Backups
* Multi-AZ Support

## Monitoring

* Amazon CloudWatch Logs
* ECS Logging
* RDS Monitoring

## Security

* IAM Roles
* Security Groups
* Private Networking
* Storage Encryption

---

# Terraform Modules

## Network Module

Creates:

* VPC
* Public Subnets
* Private Application Subnets
* Private Database Subnets
* Internet Gateway
* NAT Gateway
* Route Tables

---

## ECS Module

Creates:

* ECS Cluster
* ECS Fargate Service
* Task Definition
* Application Load Balancer
* Security Groups
* IAM Roles
* Auto Scaling

---

## RDS Module

Creates:

* PostgreSQL Database
* DB Subnet Group
* Parameter Group
* Security Group
* Backup Configuration
* Enhanced Monitoring

---

# Environments

## Development

* ECS Desired Count: 2
* RDS Instance: db.t3.micro
* Backup Retention: 7 Days
* Multi-AZ: Disabled

## Production

* ECS Desired Count: 3
* ECS Auto Scaling Enabled
* RDS Instance: db.t3.medium
* Backup Retention: 30 Days
* Multi-AZ Enabled
* Deletion Protection Enabled

---

# Prerequisites

Install the following:

* Terraform >= 1.5
* AWS CLI
* Docker
* Git

---

# Configure AWS

```bash
aws configure
```

---

# Deploy Development Environment

```bash
cd infra/envs/dev

terraform init

terraform fmt -recursive

terraform validate

terraform plan

terraform apply
```

---

# Deploy Production Environment

```bash
cd infra/envs/prod

terraform init

terraform validate

terraform plan

terraform apply
```

---

# Local Database

Start PostgreSQL locally:

```bash
cd database

docker compose up -d
```

---

# Backup Database

```bash
./scripts/backup.sh <RDS_ENDPOINT> 5432 appdb admin
```

---

# Restore Database

```bash
./scripts/restore.sh <RDS_ENDPOINT> 5432 appdb admin backup.sql
```

---

# CI/CD Pipeline

The project includes a GitHub Actions workflow that performs:

* Terraform Format Check
* Terraform Validation
* Terraform Plan
* Terraform Apply

Workflow Location:

```text
.github/workflows/terraform.yml
```

---

# Security Best Practices

* Infrastructure as Code using Terraform
* Private Networking
* IAM Least Privilege
* Remote Terraform State
* State Locking
* Security Group Based Access
* Storage Encryption
* Automated Backups

---

# Useful Terraform Commands

Format:

```bash
terraform fmt
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Destroy:

```bash
terraform destroy
```

Outputs:

```bash
terraform output
```

---

# Future Improvements

* HTTPS using AWS Certificate Manager (ACM)
* Route 53 DNS
* AWS WAF
* Secrets Manager for database credentials
* Blue/Green ECS deployments
* Monitoring dashboards with CloudWatch

---

# Author

**Mayur Ahire**

**AWS DevOps Engineer**

### Skills

* AWS
* Terraform
* Docker
* ECS
* RDS
* GitHub Actions
* CI/CD
* Linux
