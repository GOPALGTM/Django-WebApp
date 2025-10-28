# Development Environment - VPC + EKS

This directory contains the Terraform configuration for deploying a complete AWS infrastructure including VPC and EKS cluster for the development environment.

## Quick Start

```bash
# Navigate to development environment
cd terraform/aws/environments/development

# Initialize Terraform
terraform init

# Plan deployment
terraform plan -var-file="../../config/dev/ht-platform/terraform_dev.tfvars"

# Apply deployment
terraform apply -var-file="../../config/dev/ht-platform/terraform_dev.tfvars"

# Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name dev-cluster
```

## Files

- `main.tf` - Main configuration with VPC and EKS modules
- `variable.tf` - Variable definitions (no hardcoded defaults)
- `output.tf` - Output values for VPC and EKS resources
- `terraform_dev.tfvars` - All variable values (in config directory)

## What Gets Created

### VPC Infrastructure
- VPC with DNS support
- 2 Public subnets (for load balancers)
- 3 Private subnets (for EKS nodes)
- Internet Gateway + NAT Gateway
- Route tables and associations

### EKS Cluster
- EKS cluster (v1.33)
- Managed node group (t3a.medium, 2-4 nodes)
- Core addons (CoreDNS, VPC CNI, kube-proxy)
- IAM roles and policies

## Configuration

All configuration values are defined in `terraform_dev.tfvars`:
- Environment: `dev`
- Region: `us-east-1`
- Cluster: `dev-cluster`
- Node Group: `dev-nodegroup`
- Instance Type: `t3a.medium`
- Node Count: 2-4 nodes

## State Management

- Single state file: `state/dev/infrastructure.tfstate`
- S3 backend: `task-infra-devops` bucket

## Prerequisites

1. AWS CLI configured (`aws configure`)
2. Terraform installed (>= 1.0)
3. S3 bucket `task-infra-devops` exists