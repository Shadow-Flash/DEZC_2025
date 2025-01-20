terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws-region
}

resource "aws_s3_bucket" "de_zoomcamp_demo_bucket" {
  bucket        = var.bucket-name
  force_destroy = true

  tags = {
    Emp_Name    = var.employee_name_tag
    Purpose     = "Learning purpose bucket will be deleted soon"
    Environment = var.dev-env
  }
}
