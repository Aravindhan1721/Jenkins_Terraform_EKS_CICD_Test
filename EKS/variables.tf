variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

/* variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "ami_id" {
  default = "ami-03fa85deedfcac80b" # Change to your preferred AMI ID
} */