terraform {
  cloud {
    organization = "timovink"

    workspaces {
      name = "shared-infrastructure"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.6"
    }
  }
}
