# Deployment Guide

## Architecture Overview

The Django WebApp is deployed using a modern cloud-native architecture:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   GitHub        │    │   AWS EKS       │    │   AWS ECR       │
│   Actions       │───▶│   Cluster       │◀───│   Repository    │
│   CI/CD         │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐
                       │     Ingress     │
                       │    Controller   │
                       │      (LB)       │
                       └─────────────────┘
```

## Deployment Process

### 1. Infrastructure Provisioning

Deploy AWS infrastructure using Terraform:

```bash
# Navigate to development environment
cd terraform/aws/environments/development

# Initialize Terraform
terraform init

# Plan infrastructure
terraform plan -var-file="../../config/dev/terraform_dev.tfvars"

# Apply infrastructure
terraform apply -var-file="../../config/dev/terraform_dev.tfvars"
```

### 2. ECR Repository Setup

The ECR repository is created automatically via Terraform:

```bash
# Get ECR repository URL
terraform output ecr_repository_url

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 801457577298.dkr.ecr.us-east-1.amazonaws.com
```

### 3. Kubernetes Deployment

Deploy the application to EKS:

```bash
# Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name dev-cluster

# Apply Kubernetes manifests
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml
```

### 4. Verification

Verify the deployment:

```bash
# Check pod status
kubectl get pods -l app=django-webapp

# Check service
kubectl get service django-webapp-service

# Check ingress
kubectl get ingress django-webapp-ingress

# Test health endpoint
kubectl port-forward service/django-webapp-service 8080:80
curl http://localhost:8080/healthz/
```

## CI/CD Pipeline

### Pipeline Stages

1. **Test Stage**
   - Code linting with flake8
   - Unit tests execution
   - Dependency installation

2. **Build & Scan Stage**
   - Docker image build with timestamp tag (YYYYMMDDHHMMSS)
   - Vulnerability scanning with Trivy (before pushing)
   - Scan results uploaded to GitHub Security tab
   - Push to ECR (only if scan passes)

3. **Deploy Stage**
   - Update Kubernetes deployment image tag only
   - No full manifest deployment (for faster updates)
   - Simple `kubectl set image` command

### Pipeline Triggers

- Push to `main` branch: Full pipeline execution
- Pull requests: Test stage only

### Required Secrets

Configure these secrets in GitHub repository settings:

```
AWS_ACCESS_KEY_ID: Your AWS access key
AWS_SECRET_ACCESS_KEY: Your AWS secret key
AWS_REGION: AWS region (e.g., us-east-1)
EKS_CLUSTER_NAME: EKS cluster name (e.g., dev-cluster)
```

### Image Tagging Strategy

The pipeline uses timestamp-based tagging for better traceability:
- Format: `YYYYMMDDHHMMSS` (e.g., `20250128142500`)
- Also tags as `latest` for convenience
- Each deployment gets a unique, traceable tag

### Security Scanning

- **Trivy Scanner**: Scans for CRITICAL and HIGH severity vulnerabilities
- **Scan Timing**: Before pushing to ECR (fail-fast approach)
- **Results**: Available in GitHub Security tab
- **Action**: Pipeline continues even if vulnerabilities found (results logged)

## Environment Configuration

### Development Environment

- EKS Cluster: `dev-cluster`
- ECR Repository: `django-webapp`
- Namespace: `default`
- Replicas: 3 (min: 2, max: 10)

### Production Environment

- EKS Cluster: `prod-cluster`
- ECR Repository: `django-webapp-prod`
- Namespace: `production`
- Replicas: 5 (min: 3, max: 20)

## Scaling and Performance

### Horizontal Pod Autoscaler

The HPA is configured to scale based on:
- CPU utilization: 70%
- Memory utilization: 80%
- Min replicas: 2
- Max replicas: 10

### Resource Limits

Each pod has:
- CPU request: 250m, limit: 500m
- Memory request: 256Mi, limit: 512Mi

### Monitoring

Monitor the application using:
- Kubernetes metrics
- CloudWatch logs
- Application health endpoint

## Rollback Strategy

### Manual Rollback

To manually rollback:

```bash
# Check deployment history
kubectl rollout history deployment/django-webapp

# Rollback to previous version
kubectl rollout undo deployment/django-webapp

# Rollback to specific revision
kubectl rollout undo deployment/django-webapp --to-revision=2
```

**Note**: Automatic rollback is not included in the current pipeline. You can monitor deployments manually or add rollback steps if needed.

## Security Considerations

### Container Security

- Non-root user execution
- Minimal base image
- Vulnerability scanning
- Regular image updates

### Kubernetes Security

- Network policies
- Pod security policies
- RBAC configuration
- Secrets management

### AWS Security

- IAM roles with minimal permissions
- VPC security groups
- ECR repository policies
- CloudTrail logging

## Troubleshooting

### Common Issues

1. **Pod CrashLoopBackOff**
   ```bash
   kubectl describe pod <pod-name>
   kubectl logs <pod-name>
   ```

2. **ImagePullBackOff**
   ```bash
   kubectl describe pod <pod-name>
   # Check ECR permissions and image availability
   ```

3. **Service Not Accessible**
   ```bash
   kubectl get endpoints
   kubectl describe service django-webapp-service
   ```

4. **Ingress Issues**
   ```bash
   kubectl describe ingress django-webapp-ingress
   # Check ALB controller logs
   ```

### Debug Commands

```bash
# Get all resources
kubectl get all -l app=django-webapp

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp

# Port forward for debugging
kubectl port-forward service/django-webapp-service 8080:80

# Execute commands in pod
kubectl exec -it <pod-name> -- /bin/bash
```
