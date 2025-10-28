# Development Environment Configuration
# All values come from this file - no hardcoded defaults in variables

# Environment
env = "dev"
region = "us-east-1"

# VPC Configuration
vpc_cidr_block = "172.18.0.0/16"
public_subnet_cidr_blocks = ["172.18.1.0/24", "172.18.2.0/24"]
private_subnet_cidr_blocks = ["172.18.3.0/24", "172.18.4.0/24", "172.18.5.0/24"]
aws_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# VPC Tag Names
vpc_tag_name = "dev-vpc"
aws_route_table_public_tag_name = "dev-public-route-table"
aws_route_table_private_tag_name = "dev-private-route-table"
aws_internet_gateway_tag_name = "dev-internet-gateway"
public_subnet_1_tag_name = "dev-public-subnet1"
public_subnet_2_tag_name = "dev-public-subnet2"
private_subnet_1_tag_name = "dev-private-subnet1"
private_subnet_2_tag_name = "dev-private-subnet2"
private_subnet_3_tag_name = "dev-private-subnet3"

# EKS Cluster Configuration
cluster_name = "dev-cluster"
cluster_version = 1.33

# Node Group Configuration
node_group_name = "dev-nodegroup"
node_group_version = "1.32"
instance_type = "t3a.medium"
desired_size = 2
min_size = 2
max_size = 4
disk_size = 40

# ECR
repository_name = "django-webapp"
