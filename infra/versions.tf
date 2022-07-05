terraform {
  cloud {
    organization = "timovink"

    workspaces {
      name = "infra-shared"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21.0"
    }
  }
}
