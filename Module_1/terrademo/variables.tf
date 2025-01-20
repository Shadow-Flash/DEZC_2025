variable "employee_name_tag" {
  description = "Employee Name and Code"
  default     = "Varun Gupta - ANT-090"
}

variable "dev-env" {
  description = "Development environment"
  default     = "Dev"
}

variable "aws-region" {
  description = "Region where resources been deployed"
  default     = "ap-south-1"
}

variable "bucket-name" {
  description = "Name of the bucket"
  default     = "de-demo-bucket-terraform"
}
