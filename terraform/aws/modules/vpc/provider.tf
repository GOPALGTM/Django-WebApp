terraform {
  required_version = ">= 0.13.5" # You can keep this as is if you're using a compatible version of Terraform
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
