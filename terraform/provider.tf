terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region

  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}