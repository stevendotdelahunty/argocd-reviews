terraform {
  required_version = "~> 1.2.6"

  backend "s3" {
    acl     = "bucket-owner-full-control"
    bucket  = "smartlabs-terraform-state"
    encrypt = true
    region  = "eu-west-2"
    key     = "eks/review-apps/eks-infra.tfstate"
  }
}
