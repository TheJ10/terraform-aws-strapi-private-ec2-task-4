# Terraform – Terraform-Based Private EC2 Deployment with Strapi using Docker

## Overview

This repository contains a **complete, production-style Terraform project** that provisions a secure AWS infrastructure and deploys **Strapi** on a **private EC2 instance** using **Docker**, accessed via an **Application Load Balancer (ALB)**.

The infrastructure follows **AWS and Terraform best practices**, including **modular design**, **least-privilege networking**, and **no public exposure of compute resources**.

---

## Architecture Summary

- Custom VPC
- 2 Public Subnets across multiple Availability Zones
- 1 Private Subnet
- Internet Gateway for public subnets
- NAT Gateway for private subnet outbound internet access
- Application Load Balancer (public-facing)
- EC2 Instance (private, no public IP)
- Security Groups with restricted access
- Strapi application running in Docker

---

## High-Level Architecture Flow

```text
             Internet
                |
                v
Application Load Balancer (Public Subnets)
                |
                v
     EC2 Instance (Private Subnet)
                |
                v
NAT Gateway → Internet (Outbound Only)
```
---

## Folder Structure
```text
.
├── provider.tf
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── user_data.sh
└── modules
    ├── vpc
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── alb
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## Module Responsibilities
### VPC Module
- Creates VPC
- Creates public and private subnets
- Attaches Internet Gateway
- Configures NAT Gateway
- Manages route tables and associations

### Security Module
- ALB security group allowing HTTP (80) from internet
- EC2 security group allowing:
    - Application traffic only from ALB
    - Temporary SSH access via IP whitelisting

### ALB Module
- Application Load Balancer in public subnets
- Target group for Strapi
- Health checks configured
- HTTP listener on port 80

### EC2 Module
- Amazon Linux 2 EC2 instance
- Deployed in private subnet
- No public IP
- Docker installation via user data
- Runs Strapi using official Docker image

---

## Application Deployment
- Docker is installed automatically at instance boot
- Strapi is launched using the official image:
```bash
strapi/strapi
```
- No build steps
- No npm commands
- Application listens on port 1337

---

## Configuration
All configuration values are managed through a single terraform.tfvars file.

Example:
```bash
aws_region          = "ap-south-1"
project_name        = "strapi-private"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = "10.0.3.0/24"
instance_type       = "t3.small"
key_name            = "task4-key"
allowed_ssh_cidr    = "157.51.145.79/32"
```

---

## Prerequisites
- AWS account
- Terraform ≥ 1.4
- AWS CLI configured
- Existing EC2 Key Pair in the selected AWS region
- IAM permissions for EC2, VPC, ELB, IAM

---

## Deployment Steps
```bash
terraform init
terraform validate
terraform apply
```

---

## Outputs
After successful deployment, Terraform outputs:
```text
alb_dns_name = <application-load-balancer-dns>
```

---

## Accessing the Application
Open a browser and navigate to:
```text
http://<alb_dns_name>
```
The Strapi application will be accessible via the ALB.

---

## Security Considerations
- EC2 instance has no public IP
- SSH access is restricted to a specific IP
- Recommended to remove SSH access after validation
- All inbound application traffic flows through the ALB only

---

## Cleanup
To destroy all resources:
```bash
terraform destroy
```

---

## Project Outcome
- Secure, private AWS infrastructure
- Clean Terraform modular design
- Real-world DevOps implementation

---

## Loom Video
Link: https://www.loom.com/share/e8a97a4d15e145aab0d9379530b3bad0

---

## Author
Jaspal Gundla
