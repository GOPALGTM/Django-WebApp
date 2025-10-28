# Development Environment Variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "aws_availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

# VPC Tag Names
variable "vpc_tag_name" {
  description = "VPC tag name"
  type        = string
}

variable "aws_route_table_public_tag_name" {
  description = "Public route table tag name"
  type        = string
}

variable "aws_route_table_private_tag_name" {
  description = "Private route table tag name"
  type        = string
}

variable "aws_internet_gateway_tag_name" {
  description = "Internet gateway tag name"
  type        = string
}

variable "public_subnet_1_tag_name" {
  description = "Public subnet 1 tag name"
  type        = string
}

variable "public_subnet_2_tag_name" {
  description = "Public subnet 2 tag name"
  type        = string
}

variable "private_subnet_1_tag_name" {
  description = "Private subnet 1 tag name"
  type        = string
}

variable "private_subnet_2_tag_name" {
  description = "Private subnet 2 tag name"
  type        = string
}

variable "private_subnet_3_tag_name" {
  description = "Private subnet 3 tag name"
  type        = string
}

# EKS Cluster Configuration
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = number
}

# Node Group Configuration
variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "node_group_version" {
  description = "Kubernetes version for the EKS node group"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the node group"
  type        = string
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "disk_size" {
  description = "Disk size in GB for EKS nodes"
  type        = number
}

# ECR Configuration
variable "repository_name" {
  description = "ECR repository name"
  type        = string
}