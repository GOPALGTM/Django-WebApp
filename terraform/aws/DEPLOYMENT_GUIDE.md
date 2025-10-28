# Terraform AWS Infrastructure Deployment Guide

## Prerequisites

1. **AWS CLI configured**: `aws configure`
2. **Terraform installed**: Version >= 1.0
3. **S3 bucket exists**: `task-infra-devops` (for state storage)
4. **AWS credentials**: Proper IAM permissions

## Project Structure

```
terraform/aws/
├── modules/
│   ├── vpc/           # VPC module
│   └── eks/           # EKS module
├── environments/
│   └── development/   # Development environment
│       ├── main.tf           # VPC + EKS configuration
│       ├── variable.tf       # All variables (no defaults)
│       └── output.tf         # VPC + EKS outputs
└── config/
    └── dev/
        └── ht-platform/
            └── terraform_dev.tfvars  # All variable values
```

## Deployment Steps

### Single Command Deployment

```bash
# Navigate to development environment
cd terraform/aws/environments/development

# Initialize Terraform
terraform init

# Plan infrastructure deployment (VPC + EKS)
terraform plan -var-file="../../config/dev/ht-platform/terraform_dev.tfvars"

# Apply infrastructure deployment (VPC + EKS)
terraform apply -var-file="../../config/dev/ht-platform/terraform_dev.tfvars"
```

## Best Practices

### 1. State Management
- **Single state file** for VPC and EKS (simplified approach)
- **S3 backend** with versioning enabled
- **State locking** with DynamoDB (recommended)

### 2. Security
- **Private subnets** for EKS worker nodes
- **Public subnets** only for load balancers
- **NAT Gateway** for outbound internet access
- **Security groups** with least privilege

### 3. Resource Naming
- **Consistent naming convention**: `{env}-{resource}-{purpose}`
- **Tags**: Environment, Project, ManagedBy
- **Descriptive names**: Easy to identify resources

### 4. Cost Optimization
- **Right-sizing**: Start with smaller instances
- **Auto Scaling**: Configure proper min/max nodes
- **Spot instances**: For non-critical workloads
- **Resource cleanup**: Regular review and cleanup

### 5. Monitoring & Logging
- **CloudWatch**: Enable cluster and node group logging
- **Container Insights**: Monitor application performance
- **Cost monitoring**: Track spending

## Useful Commands

### Terraform Commands
```bash
# Initialize
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy

# Show current state
terraform show

# List resources
terraform state list

# Import existing resource
terraform import aws_vpc.example vpc-12345678
```

### AWS CLI Commands
```bash
# List VPCs
aws ec2 describe-vpcs

# List EKS clusters
aws eks list-clusters

# Get cluster details
aws eks describe-cluster --name dev-cluster

# Update kubeconfig
aws eks update-kubeconfig --region us-east-1 --name dev-cluster
```

### kubectl Commands
```bash
# Get nodes
kubectl get nodes

# Get pods
kubectl get pods --all-namespaces

# Describe node
kubectl describe node <node-name>
```

## Troubleshooting

### Common Issues
1. **State lock**: `terraform force-unlock <lock-id>`
2. **Permission denied**: Check IAM policies
3. **Resource conflicts**: Check naming and regions
4. **Subnet capacity**: Ensure sufficient IP addresses

### Validation
```bash
# Validate Terraform configuration
terraform validate

# Format code
terraform fmt -recursive

# Security scan
terraform plan -var-file="../../config/dev/ht-platform/terraform_dev.tfvars" | grep -i security
```

## Next Steps

1. **Configure kubectl**: `aws eks update-kubeconfig --region us-east-1 --name dev-cluster`
2. **Deploy applications**: Use Helm or kubectl
3. **Set up monitoring**: CloudWatch, Prometheus, Grafana
4. **Configure CI/CD**: GitHub Actions, GitLab CI
5. **Implement backup**: EBS snapshots, RDS backups
