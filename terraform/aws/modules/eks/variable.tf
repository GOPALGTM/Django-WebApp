variable "region" {
  description = "Region for cloud resources"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The EKS cluster version"
  type        = number
}

variable "node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "node_group_version" {
  description = "Kubernetes version to use for the EKS node group"
  type        = string
}

variable "instance_type" {
  description = "The instance types to be used for the node group."
  type        = string
}

variable "desired_size" {
  description = "The desired size of the node group."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the node group."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the node group."
  type        = number
}

variable "disk_size" {
  description = "The disk size in GB for EKS nodes."
  type        = number
}

variable "env" {
  description = "Environment value"
  type        = string
}

# VPC Information
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}
