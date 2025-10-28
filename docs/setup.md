# Django WebApp Setup Guide

## Overview

This Django web application is containerized and deployed on AWS EKS with a complete CI/CD pipeline using GitHub Actions.

## Prerequisites

- Docker installed locally
- AWS CLI configured
- kubectl installed
- Terraform installed (for infrastructure)
- GitHub repository with Actions enabled

## Local Development Setup

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/Django-WebApp.git
cd Django-WebApp
```

### 2. Create Virtual Environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run Database Migrations
```bash
cd django_web_app
python manage.py migrate
```

### 5. Create Superuser
```bash
python manage.py createsuperuser
```

### 6. Run Development Server
```bash
python manage.py runserver
```

## Docker Development

### Build Docker Image
```bash
docker build -t django-webapp .
```

### Run Container
```bash
docker run -p 8000:8000 django-webapp
```

### Test Health Check
```bash
curl http://localhost:8000/healthz/
```

## AWS Infrastructure Setup

### 1. Deploy Infrastructure with Terraform
```bash
cd terraform/aws/environments/development
terraform init
terraform plan -var-file="../../config/dev/terraform_dev.tfvars"
terraform apply -var-file="../../config/dev/terraform_dev.tfvars"
```

### 2. Configure kubectl
```bash
aws eks update-kubeconfig --region us-east-1 --name dev-cluster
```

## Kubernetes Deployment

### 1. Deploy Application
```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/hpa.yaml
```

### 2. Verify Deployment
```bash
kubectl get pods
kubectl get services
kubectl get ingress
```

## CI/CD Pipeline

The GitHub Actions pipeline includes:

1. **Test Stage**: Code linting with flake8 and unit tests
2. **Build Stage**: Docker image build with timestamp tag
3. **Security Scan**: Vulnerability scanning with Trivy (before push)
4. **Push Stage**: Push to ECR (only if scan passes)
5. **Deploy Stage**: Update deployment image tag only (no full deploy)

### Pipeline Features

- **Timestamp-based tagging**: Each build tagged with `YYYYMMDDHHMMSS` format
- **Security scanning**: Trivy scans for CRITICAL/HIGH vulnerabilities before pushing
- **Selective deployment**: Only updates image tag (faster than full deployment)
- **Automatic execution**: Triggers on push to `main` branch

### Required GitHub Secrets

Add these secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_REGION`: AWS region (e.g., us-east-1)
- `EKS_CLUSTER_NAME`: EKS cluster name (e.g., dev-cluster)

## Monitoring and Troubleshooting

### Health Check Endpoint
- URL: `/healthz/`
- Checks: Database connectivity, cache status
- Response: JSON with status and timestamp

### Common Commands

```bash
# Check pod logs
kubectl logs -f deployment/django-webapp

# Check HPA status
kubectl get hpa
```

### Troubleshooting

1. **Pod not starting**: Check logs and resource limits
2. **Health check failing**: Verify database connectivity
3. **Image pull errors**: Check ECR permissions
4. **Ingress not working**: Verify ALB controller installation

## Security Considerations

- Non-root user in container
- Secrets managed via Kubernetes secrets
- Image vulnerability scanning
- Network policies (optional)
- SSL/TLS termination at load balancer

## Performance Optimization

- Horizontal Pod Autoscaler configured
- Resource requests and limits set
- Multi-stage Docker build
- Static file serving with WhiteNoise
- Database connection pooling
