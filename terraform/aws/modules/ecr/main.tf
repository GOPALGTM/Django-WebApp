# ECR Repository
resource "aws_ecr_repository" "django_webapp" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = var.repository_name
    Project     = "ht-infra"
    ManagedBy   = "terraform"
  }
}