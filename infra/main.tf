provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Project = "tv-sharedinfra"
    }
  }
}

module "iam" {
  source = "./modules/iam"
}
