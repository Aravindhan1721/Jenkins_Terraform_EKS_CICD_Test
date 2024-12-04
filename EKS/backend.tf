terraform {
  backend "s3" {
    bucket = "aws-cicd-test"
    key    = "eks/terraform.tfstate"
    region = "eu-west-2"
  }
}