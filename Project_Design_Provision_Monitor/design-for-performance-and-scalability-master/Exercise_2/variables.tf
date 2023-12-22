# TODO: Define the variable for aws_region
variable "region" {
  type = string
  default = "us-east-1"
}

variable "aws_subnet" {
  type = string
  default = "subnet-08000c1abb20819fc"
}

variable "aws_security_group" {
  type = string
  default = "sg-017d0e8e833af393a"
}

variable "role" {
  type = string
  default = "arn:aws:iam::321256460348:role/udacity_lambda_ec2"
  # default = "arn:aws:iam::321256460348:role/service-role/S3_Udacity_Function-role-r97p0hxy"
}