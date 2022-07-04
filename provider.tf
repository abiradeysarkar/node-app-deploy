terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.16.0"
        }
    }
    backend "s3" {
        bucket = "terraform-details"
        key    = "state/terraform.tfstate"
        region = "us-east-1" 
    }
  
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}