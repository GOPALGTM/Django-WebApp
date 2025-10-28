# Development Environment Configuration
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "task-infra-devops"
    key    = "state/dev/infrastructure.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
  
  default_tags {
    tags = {
      Environment = var.env
      Project     = "ht-infra"
      ManagedBy   = "terraform"
    }
  }
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"
  
  # VPC Configuration
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  aws_availability_zones = var.aws_availability_zones
  
  # Tag Names
  vpc_tag_name = var.vpc_tag_name
  aws_route_table_public_tag_name = var.aws_route_table_public_tag_name
  aws_route_table_private_tag_name = var.aws_route_table_private_tag_name
  aws_internet_gateway_tag_name = var.aws_internet_gateway_tag_name
  public_subnet_1_tag_name = var.public_subnet_1_tag_name
  public_subnet_2_tag_name = var.public_subnet_2_tag_name
  private_subnet_1_tag_name = var.private_subnet_1_tag_name
  private_subnet_2_tag_name = var.private_subnet_2_tag_name
  private_subnet_3_tag_name = var.private_subnet_3_tag_name
  
  # Environment
  env = var.env
  region = var.region
}

# EKS Module
module "eks" {
  source = "../../modules/eks"
  
  # Cluster Configuration
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
    
  # Node Group Configuration
  node_group_name    = var.node_group_name
  node_group_version = var.node_group_version
  instance_type      = var.instance_type
  desired_size       = var.desired_size
  min_size           = var.min_size
  max_size           = var.max_size
  disk_size          = var.disk_size
  
  # VPC Information
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  
  # Environment
  env    = var.env
  region = var.region
}

# ECR (Private) Module
module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.repository_name
}
