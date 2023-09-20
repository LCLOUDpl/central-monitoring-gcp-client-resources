terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/google"
      version = ">= 4.83.0"
    }
  }
}
