variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "aws_availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vpc_tag_name" {
  description = "The name tag for the VPC"
  type        = string
}

variable "aws_route_table_public_tag_name" {
  description = "The name tag for the public route table"
  type        = string
}

variable "aws_route_table_private_tag_name" {
  description = "The name tag for the private route table"
  type        = string  
}

variable "aws_internet_gateway_tag_name" {
  description = "The name tag for the internet gateway"
  type        = string
}

variable "public_subnet_1_tag_name" {
  description = "The name tag for the first public subnet"
  type        = string  
}

variable "public_subnet_2_tag_name" {
  description = "The name tag for the second public subnet"
  type        = string  
}

variable "private_subnet_1_tag_name" {
  description = "The name tag for the first private subnet"
  type        = string
}

variable "private_subnet_2_tag_name" {
  description = "The name tag for the second private subnet"
  type        = string
}

variable "private_subnet_3_tag_name" {
  description = "The name tag for the third private subnet"
  type        = string
}

variable "env" {
  description = "Environment value"
  type        = string
}

variable "region" {
  description = "Region for cloud resources"
  type        = string
}
