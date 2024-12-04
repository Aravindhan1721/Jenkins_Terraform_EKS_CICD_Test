terraform {
  backend "s3" {
    bucket = "aws-cicd-test"
    key    = "jenkins/terraform.tfstate"
    region = "eu-west-2"
  }
}